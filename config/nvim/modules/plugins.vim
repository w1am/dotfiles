call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'

Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Colorizer
Plug 'norcalli/nvim-colorizer.lua'

" Explorer
Plug 'preservim/nerdtree'

Plug 'kyazdani42/nvim-tree.lua'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Snippets
Plug 'honza/vim-snippets'

" Auto Completion
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Colorscheme
Plug 'gruvbox-community/gruvbox'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

call plug#end()
