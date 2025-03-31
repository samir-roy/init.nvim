-- note: shinjuku config globals must be set before the color scheme

-- don't use bold and italic
vim.g.shinjuku_bold = false
vim.g.shinjuku_italic = false

-- disable theme background
vim.g.shinjuku_disable_background = true

-- set the color scheme
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
