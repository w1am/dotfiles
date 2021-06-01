let mapleader = " "

source $HOME/.config/nvim/modules/coc.vim                " Coc Settings
source $HOME/.config/nvim/modules/cursor.vim             " Cursor settings
source $HOME/.config/nvim/modules/plugins.vim            " Vim Plug
source $HOME/.config/nvim/modules/general.vim            " General Settings
source $HOME/.config/nvim/modules/snippets.vim           " Snippets
source $HOME/.config/nvim/modules/tree.vim               " NVIM Tree 
source $HOME/.config/nvim/modules/telescope.vim          " Telescope
source $HOME/.config/nvim/modules/barbar.vim             " Barbar main settings
source $HOME/.config/nvim/modules/barbar-options.vim     " Barbar options

inoremap jk <ESC>

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " remove last status
set number                              " Line numbers
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noswapfile                          " Disable swap file
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=100                      " Faster completion
set timeoutlen=501                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set termguicolors
autocmd BufRead *.md set colorcolumn=80
autocmd BufRead *.md set textwidth=80

set ma
set buftype=

lua require'plug-colorizer'
lua require'telescope-settings'

nnoremap <C-h> <C-w>h
nnoremap <M-J> <C-w>j
nnoremap <M-K> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <S-TAB> :bnext<CR>
nnoremap <TAB> :bprevious<CR>
