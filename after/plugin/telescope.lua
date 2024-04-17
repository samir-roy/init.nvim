local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
    mappings = {
      n = {
        ["q"] = "close",
      }
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["d"] = "delete_buffer",
        }
      }
    }
  }
}

telescope.load_extension('recent_files')

-- multiple remaps for git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>p', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- find files in project
vim.keymap.set('n', '<leader>fp', builtin.find_files, {})
-- search for word under the cursor
vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, {})
-- search in files using grep
vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
-- reopen last search results
vim.keymap.set('n', '<leader>fk', builtin.resume, {})
-- list of file buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>t', builtin.buffers, {})
-- list of diagnostics in project
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
-- list of recently opened files
vim.keymap.set('n', '<leader>fr', function()
  telescope.extensions.recent_files.pick({ only_cwd = true })
end)
