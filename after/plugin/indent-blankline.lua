require('ibl').setup {
  scope = {
    enabled = true,
    char = '│', -- ┆
    show_start = false,
    show_end = false,
    priority = 1,
  },
  indent = {
    char = ' ',
    priority = 9,
  }
}
