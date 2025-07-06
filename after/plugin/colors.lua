-- shinjuku theme config
vim.g.shinjuku_bold = false
vim.g.shinjuku_italic = false
vim.g.shinjuku_disable_background = true
vim.g.shinjuku_contrast_strings = false
vim.g.shinjuku_minimal_syntax = true

-- apply the color scheme
vim.cmd.colorscheme('shinjuku')

-- turn on highlight for cursor line
vim.cmd.set('cursorline')

-- configure colors for indent guides
require('ibl').setup {
  scope = {
    enabled = true,
    char = '│',
    show_start = false,
    show_end = false,
    priority = 1,
    highlight = 'IndentBlanklineIndentChar',
  },
  indent = {
    char = ' ',
    priority = 9,
  }
}

-- copilot suggestion color
vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#585858' })
