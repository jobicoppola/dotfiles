" ~/.vimrc :: jcopp.cfxd.net

"\_____________________________________________________________________________
" vundle
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
Bundle 'gmarik/vundle'

" bundles on github
Bundle 'mileszs/ack.vim.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-pathogen.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'vim-scripts/chef.vim.git'
Bundle 'tpope/vim-haml.git'
Bundle 'sickill/vim-pasta.git'
Bundle 'vim-scripts/Gist.vim.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'klen/python-mode.git'
Bundle 'vim-scripts/php.vim--Garvin.git'
Bundle 'groenewege/vim-less'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'Shougo/neocomplete.vim.git'
Bundle 'dan-bolsun/vim-nginx.git'
Bundle 'jobicoppola/vim-json-bundle.git'
Bundle 'fholgado/minibufexpl.vim.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'tpope/vim-rails.git'
Bundle 'jobicoppola/vim-jinja.git'
Bundle 'chase/vim-ansible-yaml'
Bundle 'vim-scripts/VimClojure.git'
Bundle 'jpalardy/vim-slime.git'
Bundle 'Shougo/neosnippet.vim.git'
Bundle 'moll/vim-bbye.git'
Bundle 'jiangmiao/auto-pairs.git'
Bundle 'ervandew/supertab.git'
Bundle 'honza/vim-snippets.git'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'

" shared bundles
Bundle 'L9'

filetype plugin indent on


"\_____________________________________________________________________________
" initial keybindings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable arrow keys etc
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
nnoremap ; :

" handy when caps lock remap no workee
inoremap jj <ESC>

" remap j/k to scroll by visual lines
nnoremap j gj
nnoremap k gk

" some mappings for easy capitalizations
" can also do like 2gcw to capitalize two words
nmap gcw g~w
nmap gcW g~W
nmap gciw g~wi
nmap gciW g~Wi
nmap gc$ g~$
nmap gcgc g~~
nmap gcc g~~

" remap leader key, default is \
let mapleader = ","


"\_____________________________________________________________________________
" code completion
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" autocompletion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" settings for specific filetypes
autocmd FileType ruby set expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *nginx/*.conf set ft=nginx
autocmd BufRead,BufNewFile *.wsdl set ft=xml
"autocmd BufRead,BufNewFile *.jinja,*.jinja2,*.j2 set ft=jinja


"\_____________________________________________________________________________
" colors
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on                               " syntax highlighting
color molokai_macbot                    " color scheme


"\_____________________________________________________________________________
" settings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab settings
set tabstop=4                           " how many spaces a tab counts for
set shiftwidth=4                        " spaces to use per indent step
set softtabstop=4                       " when editing, num spaces in a tab
set expandtab                           " use spaces to insert a tab
set modelines=0                         " stop exploits
set listchars=tab:▸\ ,eol:¬             " use tm symbols for tabstops/eols
set pastetoggle=<F2>                    " put vim into paste mode
set clipboard=unnamed                   " put yanks onto system clipboard
set t_Co=256                            " max terminal colors

" misc settings
set encoding=utf-8                      " default encoding type
set scrolloff=4                         " some breathing room at the bottom
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber                      " show line nums relative to cur pos
set nofoldenable                        " no code folding
set backupdir=~/tmp,/tmp                " backups (~)
set directory=~/tmp,/tmp                " swap files
set backup                              " enable backups
set wrap                                " handle long lines proper-like
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80                      " new in 7.3
set switchbuf=useopen                   " keep window layout for existing bffrs

" search options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" status line
set laststatus=2                                " always show the status line
set statusline=                                 " initialize status string
set statusline+=%f\                             " path to file
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=\[%{(&fenc==\"\"?&enc:&fenc)}]  " encoding
set statusline+=\%{fugitive#statusline()}       " fugitive
set statusline+=%=                              " right align the rest
set statusline+=0x%-8B                          " character code under cursor
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position as percent

" make fullscreen, hide toolbar, remove scrollbars
" set fu
set go-=T
set guioptions-=r
set guioptions-=L


"\_____________________________________________________________________________
" python-mode
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set default pymode options
let g:pymode_options = 1

" don't let pymode override relativenumber
let g:pymode_options_other = 0

" tell pymode not to worry about vim python paths
let g:pymode_virtualenv = 0

" don't load rope plugin
let g:pymode_rope = 0

" don't show docstring window during completion
autocmd FileType python setlocal completeopt-=preview


"\_____________________________________________________________________________
" nerdtree
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto-open nerdtree file browser
autocmd VimEnter * NERDTree

" disable relativenumber for nerdtree, taglist filetypes
autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist setlocal norelativenumber

" set nerdtree window size
let g:NERDTreeWinSize = 30

" toggles nerdtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" show current file in tree; extra cr moves focus back to the file
map <leader>f :NERDTreeFind<CR><CR>


"\_____________________________________________________________________________
" surround.vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use v or # to get a variable interpolation (inside of a string)}
" ysiw#   Wrap the token under the cursor in #{}
" v...s#  Wrap the selection in #{}
let g:surround_113 = "#{\r}"   " v
let g:surround_35  = "#{\r}"   " #

" select text in an ERb file with visual mode and then press s- or s=
" or yss- to do entire line.
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =


"\_____________________________________________________________________________
" neocomplete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" basic settings
let g:acp_enableAtStartup = 0                       " disable AutoComplPop
let g:neocomplete#enable_at_startup = 1             " use neocomplete
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#min_keyword_length = 3

" define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" plugin key-mappings
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" enable heavy omni completion
if !exists('g:neocomplete#omni_patterns')
    let g:neocomplete#omni_patterns = {}
endif
let g:neocomplete#omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'



"\_____________________________________________________________________________
" neosnippet
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" plugin key-mappings
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" for snippet_complete marker
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" enable snipmate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" user defined snippets
let g:neosnippets#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'


"\_____________________________________________________________________________
" supertab
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" reverse default tabbing direction
let g:SuperTabMappingForward = '<S-TAB>'
let g:SuperTabMappingBackward = '<TAB>'



"\_____________________________________________________________________________
" minibufexplorer settings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:miniBufExplSplitBelow = 0         " put window at top
let g:miniBufExplMapWindowNavVim = 1    " use [hjkl] for window nav
let g:miniBufExplMapWindowNavArrows = 1 " use Ctrl + Arrows for nav
let g:miniBufExplMapCTabSwitchBufs = 1  " enable ctrl-tab function mapping
let g:miniBufExplModSelTarget = 1       " if you use other buffer explorers


"\_____________________________________________________________________________
" vim clojure settings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let g:vimclojure#WantNailgun = 1
let g:vimclojure#SplitPos = "bottom"
let g:vimclojure#SplitSize = 10


"\_____________________________________________________________________________
" vim-slime
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"


"\_____________________________________________________________________________
" ctrlp
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bring up ctrlp
map <leader>p :CtrlPMixed<CR>
let g:ctrlp_working_path_mode = 0 " don't manage working directory


"\_____________________________________________________________________________
" bdelete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap :bd to use the superior functionality of bbye's :Bdelete
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bdelete<CR>' : 'bd')
nnoremap <Leader>bd :Bdelete<CR>
nnoremap <Leader>qa :bufdo :Bdelete<CR>


"\_____________________________________________________________________________
" ack
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ack shortcut
nnoremap <leader>a :Ack!


"\_____________________________________________________________________________
" git
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always go to top of commit messages
autocmd BufReadPost COMMIT_EDITMSG exec "normal! gg"


"\_____________________________________________________________________________
" more keybindings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" clear highlighting from search
nnoremap <leader><space> :noh<CR>

" use ,W to strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" a la textmate's ^Q...re-hardwrap text paragraphs
nnoremap <leader>Q gqip

" reselect just pasted text so we can e.g. indent it
nnoremap <leader>v V`]

" change existing tab chars to match current tab settings (tabs2whitespace)
nnoremap <leader>r :retab

" highlight end of line whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" returns to where you were the last time you edited the file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" save when focus is lost
au FocusLost * :wa

"\_____________________________________________________________________________
" projects
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set exrc    " allows reading of .vimrc, .exrc, .gvimrc in the cwd
set secure  " disallows shell and write commands from cwd rc files
