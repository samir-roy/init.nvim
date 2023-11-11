local function line_number()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  return string.format("%d/%d", current_line, total_lines)
end

local function column()
  local current_col = vim.fn.col('.')
  return string.format("%03d", current_col)
end

-- set up gitblame virtual text
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'
vim.g.gitblame_message_template = '<author> • <date>'
vim.g.gitblame_message_when_not_committed = 'You • Now'
local git_blame = require('gitblame')

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '│', right = '│' },
    section_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'diagnostics', 'diff' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
    lualine_y = { column },
    lualine_z = { line_number }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
})
