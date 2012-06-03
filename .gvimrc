" ~/.gvimrc :: jcopp.cfxd.net

" basic gui settings
syntax enable
set background=dark
colorscheme solarized

" os-specific
if has('unix')
    set guifont=Monospace\ 10
elseif has('macunix')
    set guifont=Menlo:h14
    set transparency=7
endif

" set window size to be as tall as possible
set lines=999 columns=160
