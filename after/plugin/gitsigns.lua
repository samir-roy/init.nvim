require('gitsigns').setup {
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '│' },
    untracked = { text = '│' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true,      -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 4000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    -- track if blame is enabled since we can only toggle
    local blame_enabled = false

    -- function to toggle blame for the current line
    function GitsignsToggleBlame()
      blame_enabled = not blame_enabled
      vim.cmd("Gitsigns toggle_current_line_blame")
    end

    -- function to disable blame if enabled
    function GitsignsDisableBlame()
      if blame_enabled then
        blame_enabled = false
        vim.cmd("Gitsigns toggle_current_line_blame")
      end
    end

    -- autocommand to turn off git blame when cursor moves
    -- vim.api.nvim_exec([[
    --   augroup ToggleBlameAutocmd
    --   autocmd!
    --   autocmd CursorMoved * lua GitsignsDisableBlame()
    --   augroup END
    -- ]], false)

    -- define command :Blame to manually trigger the function
    vim.api.nvim_exec([[
      command! Blame lua GitsignsToggleBlame()
    ]], false)

    -- toggle git blame for current line
    -- vim.api.nvim_set_keymap('n', 'gb', ':lua GitsignsToggleBlame()<CR>', { silent = true })

    local gs = package.loaded.gitsigns

    -- jump to next hunk
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr })

    -- jump to prev hunk
    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr })
  end
}
