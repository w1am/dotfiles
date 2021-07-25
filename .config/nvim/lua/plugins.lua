return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'jiangmiao/auto-pairs'
  use 'tomtom/tcomment_vim'

  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'

  use 'norcalli/nvim-colorizer.lua'

  use 'kyazdani42/nvim-tree.lua'

  use 'mhinz/vim-signify'
  use { 'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate' }

  use 'honza/vim-snippets'

  use 'wojciechkepka/vim-github-dark'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'
end)
