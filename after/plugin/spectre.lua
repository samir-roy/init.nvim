require('spectre').setup({
  color_devicons = false,
  mapping = {
    ['resume_last_search'] = {
      map = "<leader>a",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "repeat last search"
    },
  }
})

-- toggle spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open({is_insert_mode=true})<CR><C-w>o')
vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").open({is_insert_mode=true})<CR><C-w>o')

-- search for word under the cursor
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR><C-w>o')

-- search for selection in visual mode
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR><C-w>o')
