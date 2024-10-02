vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- nvim tree to replace netrw file explorer
  use { 'nvim-tree/nvim-tree.lua' }
  -- telescope for finding and opening buffers
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  }
  -- recent files in telescope
  use { 'smartpde/telescope-recent-files' }
  -- mark and jump between files
  use { 'theprimeagen/harpoon' }
  -- shinjuku color scheme
  use { 'samir-roy/shinjuku.nvim' }
  -- undo history with branching
  use { 'mbbill/undotree' }
  -- nicer status line
  use { 'nvim-lualine/lualine.nvim' }
  -- easily comment lines
  use { 'terrortylor/nvim-comment' }
  -- minimap
  use { 'gorbit99/codewindow.nvim' }
  -- start screen
  use { 'mhinz/vim-startify' }
  -- indent guides
  use { 'lukas-reineke/indent-blankline.nvim' }
  -- git signs in sign column
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  -- git blame
  use { 'f-person/git-blame.nvim' }
  -- treesitter for parsing
  use { 'nvim-treesitter/nvim-treesitter',
    { run = ':TSUpdate' },
  }
  -- language servers
  use { 'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- manage lsp servers
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- lsp support
      { 'neovim/nvim-lspconfig' },

      -- autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }
  -- show status of lsp servers
  use { 'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  }
  -- find and replace text in files
  use { 'nvim-pack/nvim-spectre',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- surround for editing surrounding delimiters
  use { 'kylechui/nvim-surround',
    tag = '*',
    config = function()
      require('nvim-surround').setup()
    end
  }
end)
