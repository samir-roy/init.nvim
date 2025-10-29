local M = {}

M.init = function()
  vim.g.mapleader = ' '

  -- leader key is noop
  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

  -- no shift command prompt
  vim.keymap.set({ 'n', 'v' }, '<Space>;', ':')

  -- easier jump to prev and next
  vim.keymap.set('n', '[[', '<C-o>')
  vim.keymap.set('n', ']]', '<C-i>')

  -- move cursor to middle when searching
  vim.keymap.set('n', 'n', 'nzz')
  vim.keymap.set('n', 'N', 'Nzz')

  -- don't use capital Q
  vim.keymap.set('n', 'Q', '<nop>')

  -- save and save all
  vim.keymap.set('n', '<leader>W', ':w<CR>')
  vim.keymap.set('n', '<leader>w', ':wa<CR>')

  -- file (buffer) close
  vim.keymap.set('n', '<leader>fc', ':bd<CR>', { silent = true })

  -- jump to last buffer (last accessed, not last in buffer list)
  vim.api.nvim_set_keymap('n', '<leader>l', '<CMD>b#<CR>', { silent = true })

  -- jump to n-th buffer in buffer list (n-th lowest numbered buffer, not the buffer number)
  vim.api.nvim_set_keymap('n', '<leader>1', '<CMD>bf<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>2', '<CMD>bf | bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>3', '<CMD>bf | 2bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>4', '<CMD>bf | 3bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>5', '<CMD>bf | 4bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>6', '<CMD>bf | 5bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>7', '<CMD>bf | 6bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>8', '<CMD>bf | 7bn<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>9', '<CMD>bf | 8bn<CR>', { silent = true })

  -- jump to prev/next buffer in buffer list
  vim.api.nvim_set_keymap('n', '<leader>[', '<CMD>bN<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>]', '<CMD>bn<CR>', { silent = true })

  -- clear search buffer
  vim.keymap.set('n', '?', [[:noh | echo ""<CR>]])

  -- jump to beginning / end
  vim.keymap.set({ 'n', 'v' }, '<leader>b', '^')
  vim.keymap.set({ 'n', 'v' }, '<leader>e', '$')

  -- similar to page down and page up
  vim.keymap.set({ 'n', 'v' }, 'J', 'j')
  vim.keymap.set({ 'n', 'v' }, '<leader>j', '<C-d>zz')
  vim.keymap.set({ 'n', 'v' }, 'K', 'k')
  vim.keymap.set({ 'n', 'v' }, '<leader>k', '<C-u>zz')

  -- easily move selected lines in visual mode
  vim.keymap.set('v', 'L', ":m '>+1<CR>gv=gv")
  vim.keymap.set('v', 'H', ":m '<-2<CR>gv=gv")

  -- map jj for easier escape out of insert mode
  vim.keymap.set('i', 'jj', '<esc>')

  -- cursor movement in insert mode
  vim.keymap.set('i', '<C-h>', '<Left>')
  vim.keymap.set('i', '<C-j>', '<Down>')
  vim.keymap.set('i', '<C-k>', '<Up>')
  vim.keymap.set('i', '<C-l>', '<Right>')

  -- paste without replacing clipboard
  vim.keymap.set('x', '<leader>P', '"_dp')

  -- yank to system clipboard
  vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
  vim.keymap.set('n', '<leader>Y', '"+Y')

  -- search and replace current word
  vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

  -- search for curent word and don't go to next match
  vim.keymap.set('n', '<leader>n', '*N')

  -- close other windows
  vim.keymap.set('n', '<leader>o', ':only<CR>', { silent = true })

  -- match to bracket
  vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')
end

-- lsp keymaps are defined during on_attach (lsp.lua)
M.set_keymaps_for_lsp = function(bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- show hover info
  vim.keymap.set('n', '<leader>i', function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
  -- list available code actions
  vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end, opts)
  -- go to definition - same as gd
  vim.keymap.set('n', '<leader>g', function() vim.lsp.buf.definition() end, opts)
  -- open diagnostics float
  vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)

  -- format using lsp
  vim.keymap.set({ 'n', 'x' }, '<leader>.', function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 3000,
    })
  end, opts)
end

-- gitsigns keymaps are defined during on_attach (gitsigns.lua)
M.set_keymaps_for_gitsigns = function(bufnr)
  local gs = require('gitsigns')

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

  vim.keymap.set('n', '<leader>U', function()
    vim.schedule(function() gs.preview_hunk() end)
    return '<Ignore>'
  end, { expr = true, buffer = bufnr })
end

-- plugin keymaps are defined after all plugins have loaded (zzzrunlast.lua)
M.set_keymaps_for_plugins = function()
  -- telescope related keymaps
  local telescope = require('telescope.builtin')

  -- picker for git files
  vim.keymap.set('n', '<C-p>', telescope.git_files, {})

  -- picker for files that are not gitignored
  vim.keymap.set('n', '<leader>p', function()
    telescope.find_files({ respect_gitignore = true, hidden = false })
  end, {})

  -- find files in project folder
  vim.keymap.set('n', '<leader>fp', telescope.find_files, {})

  -- find word under the cursor
  vim.keymap.set({ 'n', 'v' }, '<leader>fw', telescope.grep_string, {})

  -- find using grep
  vim.keymap.set('n', '<leader>ff', telescope.live_grep, {})

  -- find kontinue (reopen results)
  vim.keymap.set('n', '<leader>fk', telescope.resume, {})

  -- tabs (list of open buffers)
  vim.keymap.set('n', '<leader>t', telescope.buffers, {})

  -- list of diagnostics in project
  vim.keymap.set('n', '<leader>fd', telescope.diagnostics, {})

  -- list of recently opened files
  vim.keymap.set('n', '<leader>fr', function()
    require('telescope').extensions.recent_files.pick({ only_cwd = true })
  end)

  -- toggle file explorer using nvim-tree
  vim.keymap.set('n', '<leader>x', ':NvimTreeToggle<CR>', { silent = true })

  -- search and replace using spectre
  vim.keymap.set('n', '<leader>ss', '<CMD>lua require("spectre").open({is_insert_mode=true})<CR><C-w>o')

  -- search and replace using spectre in split screen
  vim.keymap.set('n', '<leader>S', '<CMD>lua require("spectre").open({is_insert_mode=true})<CR>')

  -- search for word under the cursor using spectre
  vim.keymap.set('n', '<leader>sw', '<CMD>lua require("spectre").open_visual({select_word=true})<CR><C-w>o')

  -- search for selection in visual mode using spectre
  vim.keymap.set('v', '<leader>sw', '<ESC><CMD>lua require("spectre").open_visual()<CR><C-w>o')

  -- show / hide undo tree
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

  -- comment / uncomment current line or selection
  vim.keymap.set({ 'n', 'x' }, '<leader>/', ':CommentToggle<CR>', { silent = true })

  -- chat with ai coding agent like claude code
  vim.keymap.set('n', '<leader>cq', ':CodeBridgeChat<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>cc', ':CodeBridgeQuery<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>cs', ':CodeBridgeTmux<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>ci', ':CodeBridgeTmuxInteractive<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>ca', ':CodeBridgeTmuxAllInteractive<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>cr', ':CodeBridgeResumePrompt<CR>', { silent = true })
  vim.keymap.set({ 'n', 'x' }, '<leader>c', '<Nop>', { silent = true })

  -- create hydras for page scrolling
  local hydra = require('hydra')
  hydra({
    name = 'scroll down',
    mode = { 'n', 'x' },
    body = '<leader>j',
    config = {
      invoke_on_body = true,
      timeout = 2000,
      hint = {
        type = 'cmdline',
        show_name = true,
      },
      on_enter = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-d>zz', true, false, true), 'n', true)
      end,
    },
    heads = {
      { 'j', '<C-d>zz', { desc = 'page down' } },
    },
  })
  hydra({
    name = 'scroll down',
    mode = { 'n', 'x' },
    body = '<leader>k',
    config = {
      invoke_on_body = true,
      timeout = 2000,
      hint = {
        type = 'cmdline',
        show_name = true,
      },
      on_enter = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-u>zz', true, false, true), 'n', true)
      end,
    },
    heads = {
      { 'k', '<C-u>zz', { desc = 'page up' } },
    },
  })
end

return M
