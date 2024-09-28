-- don't use bold and italic in the color scheme
-- must be set before the color scheme
vim.g.shinjuku_bold = false
vim.g.shinjuku_italic = false

-- set the color scheme
vim.cmd.colorscheme('shinjuku')

-- turn on highlight for cursor line
vim.cmd.set('cursorline')

-- remove theme background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
