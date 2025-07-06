local M = {}

M.init = function()
  -- look for lazy plugin manager in neovim data folder
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  -- install lazy if not already installed
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- setup all other plugins
  require("lazy").setup({
    -- shinjuku color scheme
    { 'samir-roy/shinjuku.nvim' },
    -- code-bridge for ai chat
    { 'samir-roy/code-bridge.nvim' },
    -- nicer status line
    { 'nvim-lualine/lualine.nvim' },
    -- start screen
    { 'mhinz/vim-startify' },
    -- indent guides
    { 'lukas-reineke/indent-blankline.nvim' },
    -- easily comment lines
    { 'terrortylor/nvim-comment' },
    -- nvim tree to replace netrw file explorer
    { 'nvim-tree/nvim-tree.lua' },
    -- undo history with branching
    { 'mbbill/undotree' },
    -- telescope for finding and opening buffers
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- recent files in telescope
    { 'smartpde/telescope-recent-files' },
    -- find and replace text in files
    { 'nvim-pack/nvim-spectre', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- surround for modifying surrounding delimiters
    { 'kylechui/nvim-surround', version = "^3", event = "VeryLazy" },
    -- hydra allows for custom submodes used for page scroll mapping
    { 'nvimtools/hydra.nvim' },
    -- git blame
    { 'f-person/git-blame.nvim' },
    -- git signs in sign column
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- treesitter for parsing
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- copilot
    { 'github/copilot.vim' },
    -- language server support
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      dependencies = {
        -- manage lsp servers
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- lsp support
        { 'neovim/nvim-lspconfig' },
        -- autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'j-hui/fidget.nvim' },
      }
    },
  }, {
    checker = {
      frequency = 30 * 24 * 60 * 60,
    },
  })
end

return M
