-- don't use bold and italic in the color scheme
-- must be set before color scheme
vim.g.shinjuku_bold = false
vim.g.shinjuku_italic = false
vim.g.shinjuku_cursorline_transparent = true;

-- set the color scheme
vim.cmd.colorscheme('shinjuku')

-- turn on highlight for cursor line
vim.cmd.set('cursorline')

-- remove theme background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })

-- use black background on cursor line
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#121212', fg = 'none' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = '#121212', fg = 'none' })
