require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath 'data' .. '/site',
}

require('nvim-treesitter').install({
  'javascript',
  'typescript',
  'c',
  'lua',
  'luadoc',
  'vim',
  'vimdoc',
  'query',
  'markdown',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'c', 'lua', 'vim', 'markdown', 'query' },
  callback = function() vim.treesitter.start() end,
})
