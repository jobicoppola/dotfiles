" ~/.vimrc :: jcopp.cfxd.net

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

" get pathogen going
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" auto-open nerdtree file browser
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" disable relativenumber for nerdtree, taglist filetypes
autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist setlocal norelativenumber

" use ctrl-space for autocompletion
set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" disable old vim compat, stop exploits
set nocompatible
set modelines=0

" remap leader key, default is \
let mapleader = ","

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" use same symbols as tm for tabstops/eols
set listchars=tab:▸\ ,eol:¬

" highlighting etc
syntax on
set pastetoggle=<F2>

" put anything yanked onto system clipboard
set clipboard=unnamed

" colors
set t_Co=256
color molokai_jobot

" search options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" clear highlighting from search
nnoremap <leader><space> :noh<cr>

" misc settings
set encoding=utf-8
set scrolloff=4
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
set laststatus=2
set relativenumber

" backups
" set undofile
set backupdir=~/tmp,/tmp " backups (~)
set directory=~/tmp,/tmp " swap files
set backup

" use tab key to match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" handle long lines proper-like
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=81 " new in 7.3

" save when focus is lost
au FocusLost * :wa

" highlight end of line whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" use ,W to strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" a la textmate's ^Q...re-hardwrap text paragraphs
nnoremap <leader>q gqip

" reselect just pasted text so we can e.g. indent it
nnoremap <leader>v V`]

" make fullscreen, hide toolbar, remove scrollbars
" set fu
set go-=T
set guioptions-=r
set guioptions-=L

" python love
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif

" returns to where you were the last time you edited the file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" move focus to file instead of nerdtree upon file opening
" autocmd VimEnter * wincmd l
