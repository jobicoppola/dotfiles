"\_____________________________________________________________________________
"
" ~/.vimrc :: jcopp.cfxd.net
"
" reminder on quickly creating macros - to start recording, type:
"
" `qm`   - m just an id for the register it will save to, can be any letter
" `derp` - run whatever commands you want to be in the macro, then:
" `q`    - to stop recording
" `@m`   - execute the macro
" `5@m`  - run the macro 5 times in a row
" `@@`   - repeat the last macro again
"
"\_____________________________________________________________________________
"//"`\||/`"\\""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"


"\_____________________________________________________________________________
" vim-plug
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" download plugins to ~/.vim/plugged
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" plugins on github
Plug 'preservim/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdcommenter'
Plug 'fholgado/minibufexpl.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'python-rope/ropevim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'
Plug 'jobicoppola/vim-json-bundle'
Plug 'pearofducks/ansible-vim'
Plug 'b4b4r07/vim-ansible-vault'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'
Plug 'fatih/vim-go'
Plug 'kopischke/vim-fetch'
Plug 'hashivim/vim-terraform'
Plug 'aquasecurity/vim-tfsec'
Plug 'thanethomson/vim-jenkinsfile'
Plug 'mzlogin/vim-markdown-toc'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'rizzatti/dash.vim'
Plug 'github/copilot.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }


" plugins required by deoplete
"
" note: to fix vim E605 errors loading deoplete after a homebrew/python upgrade
"
"   - check the paths being used by the vim python
"   - in vim, run `:pythonx import sys; print(sys.path)`
"   - if python paths differ from expected, deps likely need to be reinstalled
"   - install deps such as `pynvim` via the appropriate pip executable path
"   - the required commands have been moved into a script
"     - the `vim-fixes.sh` script will install `pynvim` and `jedi` `ropevim`
"     - this sorts the deoplete issues here and the ropevim / jedi issues
"       listed further down in this file
"   - run script from terminal
"
"       `bash vim-fixes.sh`
"
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'deoplete-plugins/deoplete-jedi'

" version conditional plugins
if !has("patch-8.2.1066")
    Plugin 'Shougo/neocomplete.vim'
    Plugin 'Shougo/neosnippet.vim'
    Plugin 'Shougo/neosnippet-snippets'
endif

" end vim-plug
call plug#end()

" for deoplete, specify where python binaries are
let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/opt/homebrew/bin/python3'


"\_____________________________________________________________________________
" initial keybindings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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
"

" autocompletion
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" settings for specific filetypes
autocmd FileType javascript,ruby,yaml,markdown set expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *nginx/*.conf set ft=nginx
autocmd BufRead,BufNewFile *.wsdl set ft=xml
autocmd BufNewFile,BufRead *templates/*.html set filetype=htmldjango
autocmd BufRead,BufNewFile */hosts/* set syntax=ansible_hosts


"\_____________________________________________________________________________
" colors
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" syntax highlighting
syntax on

" we want to use catppuccin-mocha with transparent background
" so we have to load in config overrides via lua
" this causes highlighting to be wonky
" thus also need to revert lua.vim
" see github issue:
"
"   https://github.com/vim/vim/issues/11277
"
" then see/run fix in `vim-fixes.sh`
"
" for `C.<color-name>` below see catppuccin nvim repo:
"
"   https://github.com/catppuccin/nvim (file /lua/catppuccin/palettes/mocha.lua)
"
lua << EOF
require("catppuccin").setup {
    flavour = "mocha",
    transparent_background = true,
    no_bold = true,
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
"

" tab settings
set tabstop=4                   " number of spaces that a <Tab> counts for
set softtabstop=4               " when editing, number of spaces a <Tab> counts for
set shiftwidth=4                " how many spaces to use per indent step
set expandtab                   " use spaces to insert a <Tab>
set listchars=tab:▸\ ,eol:¬     " use these symbols for tabstops/eols

" misc settings
set encoding=utf-8              " default encoding type
set scrolloff=4                 " min number of lines to keep above and below cursor
set autoindent                  " copy indent of current line when starting new line
set showmode                    " put message on last line if in Insert/Replace/Visual mode
set showcmd                     " show partial command on last line of screen (:w)
set hidden                      " hide abandoned buffers
set wildmenu                    " enable enhanced completion
set wildmode=list:longest       " completion mode settings
set visualbell                  " use a visual bell instead of beeping
set ttyfast                     " improve smoothness of redrawing
set ruler                       " show line and column number of cursor position
set number                      " show current line number instead of 0
set relativenumber              " show line nums relative to cur pos
set cursorline                  " highlight current line with CursorLine `hl-CursorLine`
set nofoldenable                " no code folding, can be toggled with `zi`
set backup                      " enable backups
set backupdir=~/tmp,/tmp        " where to save backups (~)
set directory=~/tmp,/tmp        " directories for swap files
set wrap                        " handle long lines proper-like
set textwidth=79                " max width of text being inserted (but not for paste)
set colorcolumn=80              " screen columns to highlight, with ColorColumn `hl-ColorColumn`
set switchbuf=useopen           " keep window layout for existing buffrs
set regexpengine=1              " fix slow scrolling in perl files issue
set clipboard=unnamed           " put yanks onto system clipboard
set pastetoggle=<F2>            " put vim into paste mode
set modelines=0                 " stop exploits by not checking lines for set commands
set t_Co=256                    " max number of terminal colors

" backspacing settings
set backspace=indent,eol,start  " indent: allow backspacing over autoindent
                                " eol: allow backspacing over line breaks (join lines)
                                " start: allow backspacing over the start of insert

" automatic formatting settings
set formatoptions=q,r,n,1       " q: allow formatting comments with `gq`
                                " r: continue comment on next line after hitting <Enter>
                                " n: recognize numbered lists when formatting text
                                " 1: don't break a line after a one-letter word

" status line settings
" used in conjunction with `User*` colors (see catppuccin lua section above)
"
set laststatus=2                                       " always show the status line
set statusline=                                        " initialize status string
set statusline+=%1*\ %<%{TrimName(gitbranch#name())}\  " current git branch
set statusline+=%2*\ %<%f\                             " path to file
set statusline+=%3*\ %h%m%r%w\                         " status flags
set statusline+=%=                                     " right align the rest
set statusline+=%4*\ %{&ff}\ \\|                       " file format (dos,unix)
set statusline+=%5*\ %{(&fenc==\"\"?&enc:&fenc)}\ \\|  " file encoding
set statusline+=%6*\ %{strlen(&ft)?&ft:'none'}\ \      " file type
set statusline+=%7*\ %(%l:%c%V%)\                      " line:character (column)
set statusline+=%8*\ %<%P\                             " curr position as % of file

" search settings
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" gui settings
set guioptions-=T  " hide toolbar
set guioptions-=r  " remove right scrollbar
set guioptions-=L  " remove left scrollbar vsplits
set termguicolors


"\_____________________________________________________________________________
" visual fixes
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" remove underline
highlight clear CursorLine
highlight CursorLineNR cterm=none

" remove bold
" e.g. terraform has too many Identifiers and thus too much bold
highlight Identifier cterm=none


"\_____________________________________________________________________________
" syntastic
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" allow shellcheck to follow source files
let g:syntastic_sh_shellcheck_args = "-x"


"\_____________________________________________________________________________
" python ropevim and jedi-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" use ropevim and jedi-vim together for auto completion
"
" note: may need to manually run script to pip install ropevim, e.g.
"
"    `bash vim-fixes.sh`
"
" also see notes toward top of this file regarding deoplete plugin and pynvim
"
" to sort the vim python deoplete jedi ropevim issues detailed here and
" above earlier in this file just run:
"
"    `bash vim-fixes.sh`
"
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
" ale - asynchronous lint engine
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" use virtualenv or poetry vars
let g:ale_python_auto_virtualenv = 1
let g:ale_python_auto_poetry = 1


"\_____________________________________________________________________________
" vim-closetag
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" use for these filetypes
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"


"\_____________________________________________________________________________
" nerdtree
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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

" toggles nerdtree; use <leader>t to bring it back
map <leader>T :execute 'NERDTreeToggle ' . getcwd()<CR>

" show current file in tree; extra cr moves focus back to the file
map <leader>t :NERDTreeFind<CR><CR>

" close nerdtree when it is the last window
autocmd BufEnter * if (winnr("$") == 1
    \ && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"\_____________________________________________________________________________
" vim-surround
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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
"

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \ "min_pattern_length": 1,
      \ })

" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"\_____________________________________________________________________________
" neocomplete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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
"

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
" ultisnips
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["snips"]


"\_____________________________________________________________________________
" supertab
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" reverse default tabbing direction
let g:SuperTabMappingForward = '<S-TAB>'
let g:SuperTabMappingBackward = '<TAB>'


"\_____________________________________________________________________________
" minibufexplorer
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

let g:miniBufExplSplitBelow = 0         " put window at top
let g:miniBufExplMapWindowNavVim = 1    " use [hjkl] for window nav
let g:miniBufExplMapWindowNavArrows = 1 " use Ctrl + Arrows for nav
let g:miniBufExplMapCTabSwitchBufs = 1  " enable ctrl-tab function mapping
let g:miniBufExplModSelTarget = 1       " if you use other buffer explorers


"\_____________________________________________________________________________
" vim-terraform
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" run `terraform fmt` when saving *.tf and *.tfvars files
let g:terraform_fmt_on_save=1

" set indent to 2 spaces to conform to hashicorp style
let g:terraform_align=1


"\_____________________________________________________________________________
" vim-markdown-toc
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

map <leader>toc :GenTocGFM<CR>
let g:vmt_auto_update_on_save = 1
let g:vmt_fence_hidden_markdown_style = 'GFM'
let g:vmt_fence_text = 'TOC vim-markdown-toc'
let g:vmt_fence_closing_text = '/TOC'


"\_____________________________________________________________________________
" vim-gitgutter
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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
"

map <leader>gb :Git blame<CR>
map <leader>gc :Git commit<CR>
map <leader>gp :Git pull<SPACE>
map <leader>gP :Git push<CR>
map <leader>gs :Git<CR>


"\_____________________________________________________________________________
" editorconfig-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

let g:EditorConfig_exclude_patterns = ['fugitive://.*']


"\_____________________________________________________________________________
" ansible-vim
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" reset indentation after 2 newlines in insert mode
let g:ansible_unindent_after_newline = 1


"\_____________________________________________________________________________
" ansible-vault
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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
"

" bring up fzf
nnoremap <leader>c :BCommits<CR>
nnoremap <leader>C :Commits<CR>
nnoremap <leader>G :GFiles?<CR>
nnoremap <leader>B :Buffers<CR>
nnoremap <leader>F :Lines<CR>
nnoremap <leader>z :Files<CR>
nnoremap <leader>f :Rg<CR>

" open fzf on bottom third
let g:fzf_layout = { 'down': '~33%' }

" hide pointless fzf statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" below we override the default :Rg to search hidden files (but not .git),
" disregard any ignore files, not follow symlinks, and not search filenames,
" (use <leader>z to search filenames). see here for syntax help:
" https://github.com/junegunn/fzf.vim/issues/346
"
command! -bang -nargs=* Rg call fzf#vim#grep("rg --no-ignore --hidden --glob '!.git' --glob '!venv' --no-follow --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" also customize the Files command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" fzf is now opened in a terminal buffer by vim and nvim, and our colorscheme
" is not applied to the filename segment of the matches, so below we override
" the default ANSI colors
"
" https://github.com/junegunn/fzf/blob/master/README-VIM.md#explanation-of-gfzf_colors
"
" from example there, below are the terminal colors for seoul256 color scheme
" these actually work pretty well with catppuccin and kitty theme but could
" be further customized later
"
if has('nvim')
    " may try to switch later so leaving here for now
    let g:terminal_color_0 = '#4e4e4e'
    let g:terminal_color_1 = '#d68787'
    let g:terminal_color_2 = '#5f865f'
    let g:terminal_color_3 = '#d8af5f'
    let g:terminal_color_4 = '#85add4'
    let g:terminal_color_5 = '#d7afaf'
    let g:terminal_color_6 = '#87afaf'
    let g:terminal_color_7 = '#d0d0d0'
    let g:terminal_color_8 = '#626262'
    let g:terminal_color_9 = '#d75f87'
    let g:terminal_color_10 = '#87af87'
    let g:terminal_color_11 = '#ffd787'
    let g:terminal_color_12 = '#add4fb'
    let g:terminal_color_13 = '#ffafaf'
    let g:terminal_color_14 = '#87d7d7'
    let g:terminal_color_15 = '#e4e4e4'
else
    let g:terminal_ansi_colors = [
        \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
        \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
        \ '#626262', '#d75f87', '#87af87', '#ffd787',
        \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4' ]
endif


"\_____________________________________________________________________________
" vim-easy-align
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"\_____________________________________________________________________________
" bdelete
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" remap :bd to use the superior functionality of bbye's :Bdelete
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bdelete<CR>' : 'bd')
nnoremap <Leader>bd :Bdelete<CR>
nnoremap <Leader>qa :bufdo :Bdelete<CR>


"\_____________________________________________________________________________
" git
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" always go to top of commit messages
autocmd BufReadPost COMMIT_EDITMSG exec "normal! gg"

" for checking and unchecking the boxes in pull request templates
" leader-X checks emptry boxes from current line down to bottom of file
" leader-xx unchecks all
nmap <leader>X :.,$s/\[ \]/\[x\]/<CR>
nmap <leader>xx :%s/\[x\]/\[ \]/<CR>


"\_____________________________________________________________________________
" dash.app
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" search for word under cursor using current keyword setup for docset to search
nmap <silent> <leader>s <Plug>DashSearch

" search for word under cursor in all docsets
nmap <silent> <leader>S <Plug>DashGlobalSearch


"\_____________________________________________________________________________
" more keybindings
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

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

" highlight end of line / trailing whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" remove end of line / trailing whitespace upon save
autocmd BufWritePre * :%s/\s\+$//e

" returns to where you were the last time you edited the file
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" automatically reload vimrc when it's saved
autocmd BufWritePost .vimrc so ~/.vimrc

" save when focus is lost
autocmd FocusLost * :wa


"\_____________________________________________________________________________
" functions
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

" trim git branch name for statusline
function! TrimName(str)
  let index = stridx(a:str, '/')
  if index >= 0
    let str = strpart(a:str, index+1)
  else
    let str = a:str
  endif
  let dash = stridx(str, '-')
  if dash >= 0
    let first_three = split(str, '-')[0:2]
  else
    return str
  endif
  if len(first_three) > 0
    return join(first_three, '-')
  else
    return 'FAIL'
  endif
endfunction

" highlight helm / go template files
" https://www.reddit.com/r/kubernetes/comments/ehpr5z/syntax_highlighting_for_helm_templates_in_vim/
function HelmSyntax()
  set filetype=yaml
  unlet b:current_syntax
  syn include @yamlGoTextTmpl syntax/gotexttmpl.vim
  let b:current_syntax = "yaml"
  syn region goTextTmpl start=/{{/ end=/}}/ contains=@gotplLiteral,gotplControl,gotplFunctions,gotplVariable,goTplIdentifier containedin=ALLBUT,goTextTmpl keepend
  hi def link goTextTmpl PreProc
endfunction
augroup helm_syntax
  autocmd!
  autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl call HelmSyntax()
augroup END


"\_____________________________________________________________________________
" projects
"\||/""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

set exrc    " allows reading of .vimrc, .exrc, .gvimrc in the cwd
set secure  " disallows shell and write commands from cwd rc files
