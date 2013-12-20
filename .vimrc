set nocompatible               " be iMproved filetype off                   " required!

"  -------------------------------------
" --------------- VUNDLE ----------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

set encoding=utf-8

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
Bundle 'scrooloose/syntastic'
let g:syntastic_jslint_checkers=['jslint']
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'jiangmiao/auto-pairs'
Bundle 'elzr/vim-json'
Bundle 'HTML-AutoCloseTag'
Bundle 'digitaltoad/vim-jade'
Bundle 'scrooloose/nerdtree'
Bundle 'edkolev/tmuxline.vim'

"Bundle 'gregsexton/MatchTag'
"Bundle 'airblade/vim-gitgutter'
"Bundle 'Townk/vim-autoclose'

" vim-scripts repos
Bundle 'AutoComplPop'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'xmledit'
"Bundle 'ctrlp.vim'
"Bundle 'AutoClose'
"Bundle 'AutoClose--Alves'
" --------------- VUNDLE ----------------
"  -------------------------------------


filetype plugin indent on     " required!
syntax on


let g:loaded_matchit = 1

" Solarized theme
let g:solarized_termtrans=1
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set incsearch
set number
set shiftwidth=2
set tabstop=2
set expandtab
set hls
set timeoutlen=1
set ttimeoutlen=1
set backspace=2

" pretty-print JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.html set filetype=html
" json.vim is here: http://www.vim.org/scripts/script.php?script_id=1945
"autocmd Syntax json sou ~/.vim/syntax/json.vim
" json_reformat is part of yajl: http://lloyd.github.com/yajl/
"autocmd FileType json set equalprg=json_reformat
"
" prettify for javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"au FileType html,xhtml,xml so ~/.vim/bundle/HTML-AutoCloseTag/ftplugin/html_autoclosetag.vim
"au FileType html,xhtml,xml so ~/.vim/bundle/vim-autoclose/plugin/AutoClose.vim

"autocmd BufReadPre,BufReadPost,FileReadPre,FileReadPost *.java execute "normal :%g/\/\*/normal! zf%"
autocmd FileType java %g/\/\*/normal! zf%
autocmd FileType java setlocal foldmethod=syntax
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" autocomplete (' and (" for code
" inoremap [' ['']<Left><Left>
" inoremap [" [""]<Left><Left>
" inoremap (' ('')<Left><Left>
" inoremap (" ("")<Left><Left>

let g:Powerline_symbols = 'fancy'

"python powerline
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/


" Always show statusline
set laststatus=2

" mappings 
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
inoremap <F2> <Esc>:w<CR>
noremap <F2> <Esc>:w<CR>
inoremap <F3> <Esc>:wq<CR>
noremap <F3> <Esc>:wq<CR>
inoremap <F4> <Esc>:q!<CR>
noremap <F4> <Esc>:q!<CR>
set pastetoggle=<F5>
noremap <F6> <Esc>:tabe 
inoremap <F6> <Esc>:tabe 
noremap <F7> <Esc>:tabp<CR>
inoremap <F7> <Esc>:tabp<CR>
noremap <F8> <Esc>:tabn<CR>
inoremap <F8> <Esc>:tabn<CR>
noremap <F9> <Esc>:tabc<CR>
inoremap <F9> <Esc>:tabc<CR>
"imap <Esc> <Esc><Esc>

map Q <Nop>
noremap % v%
inoremap <C-e> <End>

set updatetime=400

map <C-n> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree
"
