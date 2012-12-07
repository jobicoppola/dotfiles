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

" some mappings for easy capitalizations
" can also do like 2gcw to capitalize two words
nmap gcw g~w
nmap gcW g~W
nmap gciw g~wi
nmap gciW g~Wi
nmap gc$ g~$
nmap gcgc g~~
nmap gcc g~~

" auto-open nerdtree file browser
autocmd VimEnter * NERDTree

" disable relativenumber for nerdtree, taglist filetypes
autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist setlocal norelativenumber

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

" colors
syntax on                               " syntax highlighting
color molokai_macbot                    " color scheme

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

" don't let pymode override relativenumber
let g:pymode_options_other = 0

" set nerdtree window size
let g:NERDTreeWinSize = 30

" surround.vim
" use v or # to get a variable interpolation (inside of a string)}
" ysiw#   Wrap the token under the cursor in #{}
" v...s#  Wrap the selection in #{}
let g:surround_113 = "#{\r}"   " v
let g:surround_35  = "#{\r}"   " #

" select text in an ERb file with visual mode and then press s- or s=
" or yss- to do entire line.
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

" neocomplcache
" basic settings
let g:acp_enableAtStartup = 0                       " disable AutoComplPop
let g:neocomplcache_enable_at_startup = 1           " use neocomplcache
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_select = 1

" plugin key-mappings
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" enable heavy omni completion
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" for snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" user defined snippets
let g:neocomplcache_snippets_dir = '~/.vim/mysnippets/'

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)"
" end neocomplcache settings

" minibufexplorer settings
let g:miniBufExplSplitBelow = 0         " put window at top
let g:miniBufExplMapWindowNavVim = 1    " use [hjkl] for window nav
let g:miniBufExplMapWindowNavArrows = 1 " use Ctrl + Arrows for nav
let g:miniBufExplMapCTabSwitchBufs = 1  " enable ctrl-tab function mapping
let g:miniBufExplModSelTarget = 1       " if you use other buffer explorers

" vim clojure settings
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let g:vimclojure#WantNailgun = 1

" bclose settings
let bclose_multiple = 0 " don't close buffers displayed more than once

" ctrlp settings
let g:ctrlp_working_path_mode = 0 " don't manage working directory

" remap leader key, default is \
let mapleader = ","

" toggles nerdtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" show current file in tree; extra cr moves focus back to the file
map <leader>f :NERDTreeFind<CR><CR>

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" remap :bd to use the superior functionality of :Bclose
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bclose' : 'bd')

" ack shortcut
nnoremap <leader>a :Ack!

" bring up ctrlp
map <leader>p :CtrlPMixed<CR>

" clear highlighting from search
nnoremap <leader><space> :noh<CR>

" use ,W to strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" a la textmate's ^Q...re-hardwrap text paragraphs
nnoremap <leader>q gqip

" reselect just pasted text so we can e.g. indent it
nnoremap <leader>v V`]

" change existing tab chars to match current tab settings (tabs2whitespace)
nnoremap <leader>r :retab

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

" always go to top of commit messages
autocmd BufReadPost COMMIT_EDITMSG exec "normal! gg"

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" save when focus is lost
au FocusLost * :wa
