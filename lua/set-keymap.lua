vim.g.mapleader = ' '

-- easier jump to prev and next
vim.keymap.set('n', '[[', '<C-o>')
vim.keymap.set('n', ']]', '<C-i>')

-- move cursor to middle when searching
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- don't use capital Q
vim.keymap.set('n', 'Q', '<nop>')

-- file explorer
vim.keymap.set('n', '<leader>fx', vim.cmd.Ex)

-- clear search buffer
vim.keymap.set('n', '<leader>cs', [[:let @/ = ""<CR>]])

-- easier move beginning and end of line
vim.keymap.set({ 'n', 'v' }, '<leader>b', '^')
vim.keymap.set({ 'n', 'v' }, '<leader>e', '$')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')

-- similar to page down and page up
vim.keymap.set({ 'n', 'v' }, 'J', '20jzz')
vim.keymap.set({ 'n', 'v' }, 'K', '20kzz')

-- leader key is noop
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- easily move selected lines in visual mode
vim.keymap.set('v', 'L', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'H', ":m '<-2<CR>gv=gv")

-- map jj for easier escape out of insert mode
vim.keymap.set('i', 'jj', '<esc>')

-- alternative cursor movement in insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- paste without replacing clipboard
vim.keymap.set('x', '<leader>p', '"_dp')

-- yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- search and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
