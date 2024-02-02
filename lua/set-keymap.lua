vim.g.mapleader = ' '

-- leader key is noop
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- easier jump to prev and next
vim.keymap.set('n', '[[', '<C-o>')
vim.keymap.set('n', ']]', '<C-i>')

-- move cursor to middle when searching
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- don't use capital Q
vim.keymap.set('n', 'Q', '<nop>')

-- save and save all
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':wa<CR>')

-- file (buffer) close
vim.keymap.set('n', '<leader>fc', ':bd<CR>', { silent = true })

-- jump to last buffer
vim.api.nvim_set_keymap('n', '<leader>l', '<Cmd>b#<CR>', { silent = true })

-- clear search buffer
vim.keymap.set('n', '?', [[:let @/ = ""<CR>]])

-- jump to beginning / end / matching bracket
vim.keymap.set({ 'n', 'v' }, '<leader>b', '^')
vim.keymap.set({ 'n', 'v' }, '<leader>e', '$')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')

-- similar to page down and page up
vim.keymap.set({ 'n', 'v' }, 'J', '20jzz')
vim.keymap.set({ 'n', 'v' }, 'K', '20kzz')

-- easily move selected lines in visual mode
vim.keymap.set('v', 'L', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'H', ":m '<-2<CR>gv=gv")

-- map jj for easier escape out of insert mode
vim.keymap.set('i', 'jj', '<esc>')

-- cursor movement in insert mode
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
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
