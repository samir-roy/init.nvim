local codewindow = require('codewindow')

vim.api.nvim_set_hl(0, 'CodewindowBoundsBackground', { bg = '#000000' })

codewindow.setup({
  auto_enable = true,
  max_lines = 5000,
  minimap_width = 14,
  show_cursor = false,
  screen_bounds = 'background',
  window_border = 'none',
})

vim.keymap.set('n', '<leader>fm', codewindow.toggle_minimap)
