" ~/.vimrc :: jcopp.cfxd.net

"\_____________________________________________________________________________
" vundle
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

" plugins on github
Plugin 'preservim/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'preservim/nerdcommenter'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'honza/vim-snippets'
Plugin 'davidhalter/jedi-vim'
Plugin 'python-rope/ropevim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'moll/vim-bbye'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-endwise'
Plugin 'alvan/vim-closetag'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jobicoppola/vim-json-bundle'
Plugin 'pearofducks/ansible-vim'
Plugin 'b4b4r07/vim-ansible-vault'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'wellle/targets.vim'
Plugin 'fatih/vim-go'
Plugin 'kopischke/vim-fetch'
Plugin 'hashivim/vim-terraform'
Plugin 'aquasecurity/vim-tfsec'
Plugin 'thanethomson/vim-jenkinsfile'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'airblade/vim-gitgutter'
Plugin 'groovy.vim'
Plugin 'catppuccin/nvim'
Plugin 'itchyny/vim-gitbranch'

" plugins required by deoplete
"
" note: to fix vim E605 errors loading deoplete after a homebrew/python upgrade
"
"   - check the paths being used by the vim python
"   - in vim, run `:pythonx import sys; print(sys.path)`
"   - if python paths differ from expected, deps likely need to be reinstalled
"   - install deps such as `pynvim` via the appropriate pip executable path
"   - for example:
"
"       `/usr/local/opt/python@3.10/bin/pip3.10 install pynvim`
"
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

" shared plugins
Plugin 'L9'

" version conditional plugins
if !has("patch-8.2.1066")
    Plugin 'Shougo/neocomplete.vim'
endif

" plugins must be listed above this line
call vundle#end()

filetype plugin indent on

" for deoplete, specify where python binaries are
let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3'


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
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" settings for specific filetypes
autocmd FileType javascript,ruby,yaml,markdown set expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType groovy set expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufRead,BufNewFile *nginx/*.conf set ft=nginx
autocmd BufRead,BufNewFile *.wsdl set ft=xml
autocmd BufNewFile,BufRead *templates/*.html set filetype=htmldjango
autocmd BufRead,BufNewFile */hosts/* set syntax=ansible_hosts
"autocmd BufRead,BufNewFile *.jinja,*.jinja2,*.j2 set ft=jinja


"\_____________________________________________________________________________
" colors
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on                               " syntax highlighting

" we want to use catppuccin-mocha with transparent background
" so we have to load in config overrides via lua
" this causes highlighting to be wonky
" thus also need to revert lua.vim
" see github issue:
"
"   https://github.com/vim/vim/issues/11277
"
" for `C.<color-name>` below see catppuccin nvim repo:
"
"   https://github.com/catppuccin/nvim (file /lua/catppuccin/palettes/mocha.lua)
"
lua << EOF
require("catppuccin").setup {
    flavour = "mocha",
    transparent_background = true,
    highlight_overrides = {
        mocha = function(C)
            return {
                StatusLine = { bg = "#1f3320", fg = "#182319" },
                StatusLineNC = { fg = "#182319", bg = "#1a2a1c" },
                CursorLineNr = { fg = "#eaf584" },
                LineNr = { fg = C.surface0 },
                ColorColumn = { bg = "#191819" },
                VertSplit = { fg = "#182319", bg = "#2f4e33" },
                User1 = { bg = "#345638", fg = "#182319" },
                User2 = { bg = "#1b2a1b", fg = "#76ac7b" },
                User3 = { bg = "#182319", fg = "#2f4e33" },
                User4 = { bg = "#182319", fg = "#2f4e33" },
                User5 = { bg = "#182319", fg = "#2f4e33" },
                User6 = { bg = "#182319", fg = "#2f4e33" },
                User7 = { bg = "#1f3320", fg = "#528858" },
                User8 = { bg = "#76ac7b", fg = "#1e3121" },
                User9 = { bg = C.mantle, fg = C.pink },
                User0 = { bg = C.crust, fg = C.red },
            }
        end,
    },
}
EOF
colorscheme catppuccin


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
set number                              " show current line number instead of 0
set relativenumber                      " show line nums relative to cur pos
set cursorline                          " highlight current line
set nofoldenable                        " no code folding
set backupdir=~/tmp,/tmp                " backups (~)
set directory=~/tmp,/tmp                " swap files
set backup                              " enable backups
set wrap                                " handle long lines proper-like
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80                      " new in 7.3
set switchbuf=useopen                   " keep window layout for existing bffrs
set regexpengine=1                      " fix slow scrolling in perl files issue

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
" used in conjunction with User* colors
" see the catppuccin lua section above
set laststatus=2                                      " always show the status line
set statusline=                                       " initialize status string
set statusline+=%1*\ %<%{gitbranch#name()}\           " show current git branch
set statusline+=%2*\ %<%f\                            " path to file
set statusline+=%3*\ %h%m%r%w\                        " status flags
set statusline+=%=                                    " right align the rest
set statusline+=%4*\ %{&ff}\ \\|                      " file format (dos,unix)
set statusline+=%5*\ %{(&fenc==\"\"?&enc:&fenc)}\ \\| " file encoding
set statusline+=%6*\ %{strlen(&ft)?&ft:'none'}\ \     " file type
set statusline+=%7*\ %(%l:%c%V%)\                     " line:character (column)
set statusline+=%8*\ %<%P\                            " curr position as % of file

" gui options
set guioptions-=T                               " hide toolbar
set guioptions-=r                               " remove right scrollbar
set guioptions-=L                               " remove left scrollbar vsplits

" remove underline
highlight clear CursorLine
highlight CursorLineNR cterm=none


"\_____________________________________________________________________________
" syntastic
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" allow shellcheck to follow source files
let g:syntastic_sh_shellcheck_args = "-x"


"\_____________________________________________________________________________
" python ropevim and jedi-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use ropevim and jedi-vim together for auto completion
let ropevim_extended_complete = 1
let ropevim_enable_autoimport = 1
let g:ropevim_autoimport_modules = ["os.*","traceback","django.*"]
imap <S-space> <C-R>=RopeCodeAssistInsertMode()<CR>

let g:jedi#completions_command = "<C-Space>"
let g:jedi#auto_close_doc = 1
let g:jedi#goto_stubs_command = ""

"<leader>d"
let g:jedi#goto_command = ""

"<leader>g"
let g:jedi#goto_assignments_command = ""

"<leader>s"
let g:jedi#goto_definitions_command = ""

"K"
let g:jedi#documentation_command = ""

"<leader>n"
let g:jedi#usages_command = ""

"<leader>r"
let g:jedi#rename_command = ""

"<leader>R"
let g:jedi#rename_command_keep_name = ""


"\_____________________________________________________________________________
" vim-closetag
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use for these filetypes
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"


"\_____________________________________________________________________________
" nerdtree
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show hidden files
let g:NERDTreeShowHidden=1

" set nerdtree window size
let g:NERDTreeWinSize = 30

" auto-open nerdtree file browser
autocmd VimEnter * NERDTree

" go to file window instead of nerdtree window
autocmd VimEnter * wincmd p

" disable relativenumber for nerdtree, taglist filetypes
autocmd FileType nerdtree setlocal norelativenumber
autocmd FileType taglist setlocal norelativenumber

" toggles nerdtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" show current file in tree; extra cr moves focus back to the file
map <leader>F :NERDTreeFind<CR><CR>

" close nerdtree when it is the last window
autocmd BufEnter * if (winnr("$") == 1
    \ && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"\_____________________________________________________________________________
" vim-surround
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
" deoplete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \ "min_pattern_length": 1,
      \ })

" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"\_____________________________________________________________________________
" neocomplete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use neocomplete for older versions of vim
" see https://github.com/vim/vim/commit/bd84617d1a6766efd59c94aabebb044bef805b99
if !has("patch-8.2.1066")

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

    " play nice with jedi-vim
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'

endif


"\_____________________________________________________________________________
" neosnippet
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use neosnippet for older versions of vim
" see https://github.com/vim/vim/commit/bd84617d1a6766efd59c94aabebb044bef805b99
if !has("patch-8.2.1066")

    " plugin key-mappings
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " for snippet_complete marker
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    " user defined snippets
    let g:neosnippets#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

endif


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
" vim-terraform
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" run `terraform fmt` when saving *.tf and *.tfvars files
let g:terraform_fmt_on_save=1

" set indent to 2 spaces to conform to hashicorp style
let g:terraform_align=1


"\_____________________________________________________________________________
" vim-markdown-toc
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>toc :GenTocGFM<CR>
let g:vmt_auto_update_on_save = 1
let g:vmt_fence_hidden_markdown_style = 'GFM'
let g:vmt_fence_text = 'TOC vim-markdown-toc'
let g:vmt_fence_closing_text = '/TOC'


"\_____________________________________________________________________________
" vim-gitgutter
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" default is 4000 milliseconds, which is way too slow for sign updates
set updatetime=150

" clear background color of sign column (use same color as main bg)
let g:gitgutter_override_sign_column_highlight = 1
highlight clear SignColumn

" customize signs here
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '»'
let g:gitgutter_sign_removed = '←'
let g:gitgutter_sign_removed_first_line = '↑'
let g:gitgutter_sign_modified_removed = '‹'

" sign colors
highlight GitGutterAdd    ctermfg=78
highlight GitGutterChange ctermfg=218
highlight GitGutterDelete ctermfg=196


"\_____________________________________________________________________________
" vim-fugitive
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>gb :Gblame<CR>
map <leader>gc :Gcommit<CR>
map <leader>gp :Gpull<SPACE>
map <leader>gs :Gstatus<CR><C-w>20+
map <leader>gw :Gwrite<CR>


"\_____________________________________________________________________________
" editorconfig-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EditorConfig_exclude_patterns = ['fugitive://.*']


"\_____________________________________________________________________________
" ansible-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" reset indentation after 2 newlines in insert mode
let g:ansible_unindent_after_newline = 1


"\_____________________________________________________________________________
" ansible-vault
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ansible_vault_password_file = $ANSIBLE_VAULT_PASSWORD_FILE
nmap <leader>i :call InlineEncrypt()<CR>
nmap <leader>u :call InlineDecrypt()<CR>
function! InlineDecrypt()
    silent exe 'normal viiy'
    silent exe 'e tmp'
    silent exe 'normal P=G'
    silent exe 'AnsibleVaultDecrypt'
    silent exe 'normal ggyG'
    silent exe 'Bdelete!'
    silent exe 'normal viipkJd3bx'
endfunction
function! InlineEncrypt()
    silent exe 'e tmp'
    silent exe 'normal P=G'
    silent exe 'AnsibleVaultEncrypt'
    silent exe 'normal ggyG'
    silent exe 'Bdelete!'
    silent exe 'normal o'
    silent exe 'normal kA!vault |'
    silent exe 'normal p=}v}>'
    silent exe 'normal kwwdw'
endfunction


"\_____________________________________________________________________________
" fzf
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bring up fzf
nnoremap <leader>z :FZF<CR>
nnoremap <leader>f :Rg<CR>
let g:fzf_layout = { 'down': '~25%' }

" below we override the default :Rg to search hidden files (but not .git),
" disregard any ignore files, not follow symlinks, and not search filenames,
" (use <leader>z to search filenames). see here for syntax help:
" https://github.com/junegunn/fzf.vim/issues/346
"
command! -bang -nargs=* Rg call fzf#vim#grep("rg --no-ignore --hidden --glob '!.git' --glob '!venv' --no-follow --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)


"\_____________________________________________________________________________
" vim-easy-align
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"\_____________________________________________________________________________
" bdelete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap :bd to use the superior functionality of bbye's :Bdelete
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bdelete<CR>' : 'bd')
nnoremap <Leader>bd :Bdelete<CR>
nnoremap <Leader>qa :bufdo :Bdelete<CR>


"\_____________________________________________________________________________
" git
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always go to top of commit messages
autocmd BufReadPost COMMIT_EDITMSG exec "normal! gg"

" for pull request templates
nmap <leader>X :%s/\[ \]/\[x\]/<CR>
nmap <leader>xx :%s/\[x\]/\[ \]/<CR>


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
nnoremap <leader>r :retab<CR>

" reformat json with jq
nnoremap <leader>j :%!jq .<CR>
nnoremap <leader>J :%!jq --indent 4 .<CR>

" quickly add newlines above and below cursur
nnoremap <leader>nlo o<ESC>
nnoremap <leader>nll O<ESC>

" highlight end of line whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" returns to where you were the last time you edited the file
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" automatically reload vimrc when it's saved
autocmd BufWritePost .vimrc so ~/.vimrc

" save when focus is lost
autocmd FocusLost * :wa


"\_____________________________________________________________________________
" projects
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set exrc    " allows reading of .vimrc, .exrc, .gvimrc in the cwd
set secure  " disallows shell and write commands from cwd rc files

