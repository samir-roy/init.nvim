local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.load_extension('recent_files')

-- lots of remaps for git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>p', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- find files in project
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- search for word under the cursor
vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, {})
-- search in files using grep
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
-- reopen last search results
vim.keymap.set('n', '<leader>fk', builtin.resume, {})
-- list of file buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- list of diagnostics in project
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
-- list of recently opened files
vim.keymap.set('n', '<leader>fr', function()
  telescope.extensions.recent_files.pick({ only_cwd = true })
end)
