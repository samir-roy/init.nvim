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
vim.keymap.set('n', '<leader>W', ':w<CR>')
vim.keymap.set('n', '<leader>w', ':wa<CR>')

-- file (buffer) close
vim.keymap.set('n', '<leader>fc', ':bd<CR>', { silent = true })

-- jump to last buffer (last accessed, not last in buffer list)
vim.api.nvim_set_keymap('n', '<leader>l', '<Cmd>b#<CR>', { silent = true })

-- jump to n-th buffer in buffer list (n-th lowest numbered buffer, not the buffer number)
vim.api.nvim_set_keymap('n', '<leader>1', '<Cmd>bf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', '<Cmd>bf | bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', '<Cmd>bf | 2bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', '<Cmd>bf | 3bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', '<Cmd>bf | 4bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>6', '<Cmd>bf | 5bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>7', '<Cmd>bf | 6bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>8', '<Cmd>bf | 7bn<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>9', '<Cmd>bf | 8bn<CR>', { silent = true })

-- jump to prev/next buffer in buffer list
vim.api.nvim_set_keymap('n', '<leader>[', '<Cmd>bN<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>]', '<Cmd>bn<CR>', { silent = true })

-- clear search buffer
vim.keymap.set('n', '?', [[:let @/ = "" | echo ""<CR>]])

-- jump to beginning / end / matching bracket
vim.keymap.set({ 'n', 'v' }, '<leader>b', '^')
vim.keymap.set({ 'n', 'v' }, '<leader>e', '$')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')

-- similar to page down and page up
vim.keymap.set({ 'n', 'v' }, 'J', '20jzz')
vim.keymap.set({ 'n', 'v' }, '<leader>j', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, 'K', '20kzz')
vim.keymap.set({ 'n', 'v' }, '<leader>k', '<C-u>zz')

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

-- search for curent word and don't go to next match
vim.keymap.set('n', '<leader>n', '*N')
