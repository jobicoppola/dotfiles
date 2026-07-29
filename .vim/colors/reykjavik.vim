"
" REYKJAVIK.VIM
"
" reykjavik vim color file
" https://github.com/mswift42/vim-themes/blob/master/colors/reykjavik.vim
"
" @jobicoppola customized version
"
" Originally created with ThemeCreator
" https://github.com/mswift42/themecreator
"
" Web version
" https://mswift42.github.io/themecreator/
"
" Vim docs
" https://vimhelp.org/
"

hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
let g:colors_name = "reykjavik"


" Define reusable colorvariables.
"
" backgrounds
let s:bg="#112328"       " dark cyan gray
let s:bg2="#243539"      " dark grayish cyan
let s:bg3="#37464a"      " darkish gray
let s:bg4="#4a585c"      " gray
"
" foregrounds
let s:fg="#b1b1b1"       " light gray
let s:fg2="#a3a3a3"      " light gray (horizontal minibufexplorer bar?)
let s:fg3="#959595"      " light gray (vertical neotree bar?)
let s:fg4="#878787"      " light gray"
"
" others
let s:keyword="#a3d4e8"  " light blue
let s:builtin="#c4cbee"  " lavender
let s:const="#a3d6cc"    " light green
let s:comment="#5d5d5d"  " gray
let s:func="#f1c1bd"     " peachy red
let s:str="#e6c2db"      " grayish pink
let s:type="#c1d2b1"     " light army-ish green
let s:var="#e1c9aa"      " light orange
let s:warning="#e81050"  " dark pinkish red
let s:warning2="#e86310" " orange
"
" custom colors jcopp
let s:colorcol="#191819" " dark gray for colorcolumn (at 80 chars)
let s:fg0="#003333"      " dark green ocean
let s:bg0="#111c24"      " dark cyan blue ocean
let s:comment0="#416b6b" " greenish bluish gray
let s:keyword0="#a8e8d9" " very light blue green
let s:sev1="#ff2600"     " severity level 1 red
let s:sev2="#ff9300"     " severity level 2 orange
let s:sev3="#fffc79"     " severity level 2 yellow
let s:sev4="#76d6ff"     " severity level 4 blue
let s:sev5="#73fa79"     " severity level 5 green
let s:banana="#fffc79"   " banana yellow
let s:tang="#ffcc99"     " light orange
let s:grape="#9437ff"    " purple
let s:purple="#5f5f8a"   " muted purple
let s:lpurple="#640160"  " light purple
let s:orchid="#7a81ff"   " lighter purple
let s:plum="#942193"     " purple with some pink
let s:magenta="#ff40ff"  " magenta (bright pink)
let s:pink="#f5ceff"     " light pink
let s:darkred="#941100"  " dark red
let s:user1fg="#c9f9ff"  " light blue
let s:user1bg="#096e7a"  " dark blue

" user colors
"
exe 'hi User1 cterm=italic guifg='s:user1fg' guibg='s:user1bg

" various groupings
"
exe 'hi Normal guifg='s:fg' guibg='s:bg
exe 'hi Cursor guifg='s:bg' guibg='s:fg
exe 'hi CursorLine  guibg='s:bg2
exe 'hi CursorColumn  guibg='s:bg2
exe 'hi MatchParen guifg='s:warning2'  gui=underline'
exe 'hi Pmenu guifg='s:fg' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3
exe 'hi IncSearch guifg='s:bg' guibg='s:keyword
exe 'hi Search   gui=underline'
exe 'hi Directory guifg='s:const
exe 'hi Folded guifg='s:fg4' guibg='s:bg
"
"exe 'hi ColorColumn  guibg='s:bg2
"exe 'hi LineNr guifg='s:fg2' guibg='s:bg2
"exe 'hi VertSplit guifg='s:fg3' guibg='s:bg3
"exe 'hi StatusLine guifg='s:fg2' guibg='s:bg3' gui=bold'
"
" customizations of commented lines in above group
" plus additional items not set in original colorscheme
"
" line numbers
exe 'hi LineNr guifg='s:fg0' guibg='s:bg2
" current line number
exe 'hi CursorLineNr guifg='s:banana
" used on vertical separators e.g. nerdtree
exe 'hi VertSplit guifg='s:bg0' guibg='s:bg4
" vertical bar that shows 80th character
exe 'hi ColorColumn  guibg='s:colorcol
" used for horizontal separators e.g. minibufexplorer
exe 'hi StatusLineNC guifg='s:bg0' guibg='s:bg4' gui=bold'
" seems only to be used when first opening?
exe 'hi StatusLine guifg='s:sev5' guibg='s:bg0' gui=bold'

exe 'hi Boolean guifg='s:const
exe 'hi Character guifg='s:const
"exe 'hi Comment guifg='s:comment
exe 'hi Comment guifg='s:comment0
"exe 'hi Conditional guifg='s:keyword
exe 'hi Conditional guifg='s:keyword0
exe 'hi Constant guifg='s:const
"exe 'hi Define guifg='s:keyword
exe 'hi Define guifg='s:keyword0
exe 'hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold'
exe 'hi DiffDelete guibg='s:bg2
exe 'hi DiffChange  guibg=#151b3c guifg=#fafafa'
exe 'hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold'

"exe 'hi ErrorMsg guifg='s:warning' guibg='s:bg2' gui=bold'
exe 'hi ErrorMsg guifg='s:pink' guibg='s:warning' gui=bold'

"exe 'hi WarningMsg guifg='s:fg' guibg='s:warning2
exe 'hi WarningMsg guifg='s:tang' guibg='s:warning2

exe 'hi Float guifg='s:const
exe 'hi Function guifg='s:func
exe 'hi Identifier guifg='s:type'  gui=italic'
"exe 'hi Keyword guifg='s:keyword'  gui=bold'
exe 'hi Keyword guifg='s:keyword0'  gui=bold'
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:bg4' guibg='s:bg2
exe 'hi Number guifg='s:const
"exe 'hi Operater guifg='s:keyword
exe 'hi Operater guifg='s:keyword0
"exe 'hi PreProc guifg='s:keyword
exe 'hi PreProc guifg='s:keyword0
exe 'hi Special guifg='s:fg
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2
"exe 'hi Statement guifg='s:keyword
exe 'hi Statement guifg='s:keyword
exe 'hi StorageClass guifg='s:type'  gui=italic'
exe 'hi String guifg='s:str
"exe 'hi Tag guifg='s:keyword
exe 'hi Tag guifg='s:keyword
exe 'hi Title guifg='s:fg'  gui=bold'
exe 'hi Todo guifg='s:fg2'  gui=inverse,bold'
exe 'hi Type guifg='s:type
exe 'hi Underlined   gui=underline'

" Ruby Highlighting
exe 'hi rubyAttribute guifg='s:builtin
exe 'hi rubyLocalVariableOrMethod guifg='s:var
exe 'hi rubyGlobalVariable guifg='s:var' gui=italic'
exe 'hi rubyInstanceVariable guifg='s:var
exe 'hi rubyKeyword guifg='s:keyword
exe 'hi rubyKeywordAsMethod guifg='s:keyword' gui=bold'
exe 'hi rubyClassDeclaration guifg='s:keyword' gui=bold'
exe 'hi rubyClass guifg='s:keyword' gui=bold'
exe 'hi rubyNumber guifg='s:const

" Python Highlighting
exe 'hi pythonBuiltinFunc guifg='s:builtin

" Go Highlighting
exe 'hi goBuiltins guifg='s:builtin

" Javascript Highlighting
exe 'hi jsBuiltins guifg='s:builtin
exe 'hi jsFunction guifg='s:keyword' gui=bold'
exe 'hi jsGlobalObjects guifg='s:type
exe 'hi jsAssignmentExps guifg='s:var

" Html Highlighting
exe 'hi htmlLink guifg='s:var' gui=underline'
exe 'hi htmlStatement guifg='s:keyword
exe 'hi htmlSpecialTagName guifg='s:keyword

" Markdown Highlighting
exe 'hi mkdCode guifg='s:builtin

" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=NONE
hi MBEChanged              guifg=#F1266F guibg=NONE
hi MBEVisibleNormal        guifg=#386d76 guibg=NONE
hi MBEVisibleChanged       guifg=#F1266F guibg=NONE
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=#013542 " show bg on active only
hi MBEVisibleActiveChanged guifg=#F1266F guibg=#013542 " show bg on active only
