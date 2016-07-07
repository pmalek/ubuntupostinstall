set nocompatible               " be iMproved
filetype off     " required!

set encoding=utf-8
" -------------------------------------
" --------------- VUNDLE --------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:Powerline_symbols = 'fancy'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
let g:syntastic_jslint_checkers=['jshint']
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_python_pylint_args="--module-rgx='[a-z_][a-z0-9_-]{2,30}$'"
let g:syntastic_c_compiler_options = "-std=c11"
let g:syntastic_cpp_compiler_options = "-std=c++14"
let g:syntastic_cpp_include_dirs = ['src/', 'include/']
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 1
let g:ycm_confirm_extra_conf = 0 " prevent confirmation for loading .ycm_extra_conf.py
" let g:syntastic_java_javac_classpath = "$JAVA_HOME/jre/lib"
let g:syntastic_mode_map = { 'passive_filetypes': ['java'] }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = 'full'
let g:tmuxline_theme = 'powerline'

Plugin 'rhysd/vim-clang-format'
" let g:clang_format#code_style = 'chromium'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -2,
            \ "AlignTrailingComments" : "true",
            \ "AlignAfterOpenBracket" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "AllowShortFunctionsOnASingleLine" : "Inline",
            \ "BreakBeforeBraces" : "Allman",
            \ "BinPackParameters" : "false",
            \ "Standard" : "C++11",
            \ "ColumnLimit" : 128,
            \ "UseTab" : "Never" }
" map to <Leader>cf in C++ code
autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp nnoremap <buffer><F9> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><F9> :ClangFormat<CR>



Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" ctrl-l for snippet expand...
let g:UltiSnipsExpandTrigger="<c-l>"
" ... and ctrl-m to jump forward inside it between placeholders
let g:UltiSnipsJumpForwardTrigger="<c-m>"
" or ctrl-z to jump backwards
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" highlight xml tags
Plugin 'Valloric/MatchTagAlways'

" vim-scripts repos
Plugin 'AutoComplPop'
Plugin 'L9'
Plugin 'xmledit'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMixed'
set wildignore+=*/tmp/*,*.a,*.so,*.swp,*.zip,*.tar.gz,*.deb
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Golang Plugins
Plugin 'fatih/vim-go'
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

Plugin 'majutsushi/tagbar'
let g:tagbar_width = 60
let g:tagbar_sort = 0
let g:tagbar_indent = 0
let g:tagbar_show_linenumbers = -1
nmap <F8> :TagbarToggle<CR>

Plugin 'benmills/vimux'
" run unit tests ...
autocmd FileType c,cpp nnoremap <Leader>t :call VimuxRunCommand(" (cd ../*_build && make &&./test/*_test) ")<cr>

Plugin 'rking/ag.vim'
Plugin 'jamessan/vim-gnupg'
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
nmap <Leader>g :GitGutterToggle<CR>
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
set clipboard=unnamed
set list

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Always show statusline
set laststatus=2

" -------------------------------------
" mappings
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
noremap <silent> <C-S> :w<CR>
inoremap <silent> <C-S> <Esc>:w<CR>
noremap <silent> <C-A> :wq<CR>

imap jj <Esc>
inoremap <F2> <Esc>:w<CR>
noremap <F2> <Esc>:w<CR>
inoremap <F3> <Esc>:wq<CR>
noremap <F3> <Esc>:wq<CR>
inoremap <F4> <Esc>:q!<CR>
noremap <F4> <Esc>:q!<CR>
set pastetoggle=<F5>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
set so=6
set cursorline
set mouse=a
