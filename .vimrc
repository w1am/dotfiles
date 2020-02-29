call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
call plug#end()

let mapleader = "," 

syntax on

set clipboard=unnamedplus
set mouse=a
set number
set nospell
set confirm
set expandtab
set shiftwidth=2  
set tabstop=2
set softtabstop=2
set hlsearch
set ai
set nobackup
set noswapfile
set path+=**
set hidden
set background=dark
set incsearch
set t_Co=256
set scrolljump=5
set lazyredraw
set synmaxcol=180

function GetVisualSelection()
  let raw_search = @"
  let @/=substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction
xnoremap // ""y:call GetVisualSelection()<bar>:set hls<cr>
if has('nvim')
  set inccommand=nosplit
  xnoremap /s ""y:call GetVisualSelection()<cr><bar>:%s/
else
  xnoremap /s ""y:call GetVisualSelection()<cr><bar>:%s//
endif"

nnoremap <C-k> :-5<CR>
inoremap <C-k> <Esc>:-5<CR> i
nnoremap <C-j> :+5<CR>
inoremap <C-j> <Esc>:+5<CR> i

inoremap <leader>w <Esc>:w<CR>
nnoremap <leader>w :w<CR>

inoremap <leader>q <ESC>:q<CR>
nnoremap <leader>q :q<CR>

inoremap <leader>x <ESC>:x<CR>
nnoremap <leader>x :x<CR>

set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

map <S-k> <Nop>

map <Leader>v cw<C-r>0<ESC>

colorscheme default

inoremap jk <ESC>

nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <Leader>w <C-w>w

imap <C-Return> <CR><CR><C-o>k<Tab>

augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
augroup END

func! AutoClose(...)
    let cur = getline(".")[col(".")]
    if cur != a:1
        if a:1 == "'" || a:1 == '"'
            execute "normal!a".a:1.a:1
        else
            execute "normal!a".a:1
        endif
        execute "normal!h"
    else
        execute "normal!l"
    endif
endfunc

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <ESC>:call AutoClose(')') <CR>a
inoremap ] <ESC>:call AutoClose(']') <CR>a
inoremap } <ESC>:call AutoClose('}') <CR>a
inoremap " <ESC>:call AutoClose('"') <CR>a
inoremap ' <ESC>:call AutoClose("'") <CR>a
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

let g:netrw_banner = 0
let g:hybrid_custom_term_colors = 1
let g:loaded_matchparen=1

highlight Comment ctermfg=green
au Filetype python setl et ts=2 sw=2
filetype indent on
