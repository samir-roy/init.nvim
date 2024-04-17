require('spectre').setup({
  color_devicons = false,
})

-- toggle spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>')
vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>')

-- search for word under the cursor
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')

-- search for selection in visual mode
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>')
