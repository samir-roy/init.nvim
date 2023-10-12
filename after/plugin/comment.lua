-- set up nvim-comment
require('nvim_comment').setup({
  comment_empty = false,
})

-- map to leader slash
vim.keymap.set({ 'n', 'x' }, '<leader>/', ':CommentToggle<CR>', { silent = true })
