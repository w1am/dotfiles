set guicursor=n-v-c:block-Cursor

nnoremap <silent> <Leader>l :nohlsearch<CR><C-L>

nnoremap <C-k> :-5<CR>
inoremap <C-k> <Esc>:-5<CR> i
nnoremap <C-j> :+5<CR>
inoremap <C-j> <Esc>:+5<CR> i

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

" Save cursor position
augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
augroup END
