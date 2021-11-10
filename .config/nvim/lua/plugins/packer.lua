return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'numToStr/Comment.nvim'

  use 'jiangmiao/auto-pairs'

  use 'romgrk/barbar.nvim'

  use 'tanvirtin/monokai.nvim'

  use 'folke/lsp-colors.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }

  use 'kyazdani42/nvim-web-devicons'

  use 'nvim-treesitter/nvim-treesitter'

  use 'neovim/nvim-lspconfig'

  use 'williamboman/nvim-lsp-installer'

  use 'glepnir/lspsaga.nvim'

  use 'folke/trouble.nvim'

  use 'christoomey/vim-tmux-navigator'

  use { 'hrsh7th/nvim-cmp',
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim"
    },
  }

  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end,
  }

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, { 'BurntSushi/ripgrep' }}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)
