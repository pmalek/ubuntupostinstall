set nocompatible               " be iMproved 
filetype off     " required!

set encoding=utf-8
" -------------------------------------
" --------------- VUNDLE --------------
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:
" original repos on github
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:Powerline_symbols = 'fancy'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
let g:syntastic_jslint_checkers=['jshint']
" let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_java_javac_classpath = "$JAVA_HOME/jre/lib"
let g:syntastic_cpp_compiler_options = "-std=c++11"
Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = 'full'
let g:tmuxline_theme = 'powerline'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-jade'
Plugin 'briancollins/vim-jst'
Plugin 'elzr/vim-json'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" highlight xml tags
Plugin 'Valloric/MatchTagAlways'

" Plugin 'scrooloose/nerdcommenter'
" Plugin 'gregsexton/MatchTag'
" Plugin 'Townk/vim-autoclose'

" vim-scripts repos
Plugin 'AutoComplPop'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'xmledit'
"Plugin 'ctrlp.vim'
"Plugin 'AutoClose'
"Plugin 'AutoClose--Alves'
call vundle#end()
" --------------- VUNDLE --------------
" -------------------------------------

filetype plugin indent on     " required!
syntax on


" Solarized theme
let g:solarized_termtrans=1
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set incsearch
set number
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set hls
set timeoutlen=3000
set ttimeoutlen=1000
set backspace=2

" pretty-print JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.html set filetype=html
autocmd BufRead,BufNewFile *.ejs set filetype=jst
autocmd BufRead,BufNewFile *.jade set filetype=jade
autocmd BufRead,BufNew *.md set filetype=markdown


" json.vim is here: http://www.vim.org/scripts/script.php?script_id=1945
"autocmd Syntax json sou ~/.vim/syntax/json.vim
" json_reformat is part of yajl: http://lloyd.github.com/yajl/
"autocmd FileType json set equalprg=json_reformat
"
" prettify for javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" autocmd BufReadPre,BufReadPost,FileReadPre,FileReadPost *.java execute "normal :%g/\/\*/normal! zf%"
" autocmd FileType java %g/\/\*/normal! zf%
" autocmd FileType java setlocal foldmethod=syntax

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Always show statusline
set laststatus=2

" -------------------------------------
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
" imap <Esc> <Esc><Esc>
map Q <Nop>
" noremap % v%
inoremap <C-e> <End>
noremap <Space> za
" -------------------------------------
command Filepath echo expand('%:p')
" -------------------------------------

set updatetime=200

map <C-n> :NERDTreeToggle<CR>
map <C-c> :SyntasticCheck<CR>
"autocmd vimenter * NERDTree

" Overriden by solarized theme
"hi LineNr cterm=bold ctermfg=220
" Set 8 lines to the cursor - when moving vertically using j/k
set so=8
set cursorline
