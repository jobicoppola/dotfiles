" ~/.vimrc :: jcopp.cfxd.net

" get pathogen going
runtime bundle/pathogen/autoload/pathogen.vim
filetype off
call pathogen#infect()
filetype plugin indent on

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

" use tm/st2 style cmd key indenting
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" auto-open nerdtree file browser
autocmd VimEnter * NERDTree

" disable relativenumber for nerdtree, taglist filetypes
autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist setlocal norelativenumber

" autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" colors
syntax on                               " syntax highlighting
color molokai_jobot                     " color scheme

" tab settings
set tabstop=4                           " how many spaces a tab counts for
set shiftwidth=4                        " spaces to use per indent step
set softtabstop=4                       " when editing, num spaces in a tab
set expandtab                           " use spaces to insert a tab
set nocompatible                        " doesn't work well with ft detect
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

" don't let pymode override relativenumber
let g:pymode_options_other = 0

" remap leader key, default is \
let mapleader = ","

" toggle nerdtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" ack shortcut
nnoremap <leader>a :Ack<CR>

" clear highlighting from search
nnoremap <leader><space> :noh<cr>

" use ,W to strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" a la textmate's ^Q...re-hardwrap text paragraphs
nnoremap <leader>q gqip

" reselect just pasted text so we can e.g. indent it
nnoremap <leader>v V`]

" highlight end of line whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" python love
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
endif

" returns to where you were the last time you edited the file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" save when focus is lost
au FocusLost * :wa
