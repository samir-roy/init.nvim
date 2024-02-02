local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- add file to list of files tracked by harpoon
vim.keymap.set('n', '<leader>fa', mark.add_file)
-- open harpoon quick menu
vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu)
