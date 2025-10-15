local M = {}

M.init = function()
  -- disable netrw (see nvim-tree)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- turn on line numbers
  vim.opt.nu = true
  -- use relative line numbers
  vim.opt.relativenumber = true

  -- two space tabs
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.wrap = false

  -- turn off backup
  vim.opt.swapfile = false
  vim.opt.backup = false
  -- persist undo history instead
  vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
  vim.opt.undofile = true

  -- highlight search results
  vim.opt.hlsearch = true
  -- incremental search
  vim.opt.incsearch = true

  -- terminal gui colors
  vim.opt.termguicolors = true

  -- stay away from edge when scrolling
  vim.opt.scrolloff = 16

  -- show the sign column for lsp and git indicators
  vim.opt.signcolumn = 'yes'

  -- show guide at 120 column width
  -- vim.opt.colorcolumn = { 120 }

  -- allow hyphens in file names
  vim.opt.isfname:append('@-@')

  -- change the end of buffer character (default ~)
  vim.o.fillchars = vim.o.fillchars .. 'eob:·'

  -- turn on smartcase when searching
  vim.cmd('set ignorecase smartcase')

  -- check for file changes when switching focus
  vim.api.nvim_create_autocmd({ 'FocusGained' }, { pattern = '*', command = 'checktime' })

  -- user defined function to copy relative path
  vim.api.nvim_create_user_command('CopyRelPath', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path)
  end, {})

  -- format using dprint
  vim.api.nvim_create_user_command('F', function()
    vim.cmd('write')
    vim.cmd('silent! !npx dprint fmt %')
  end, {})
end

return M
