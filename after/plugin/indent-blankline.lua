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
