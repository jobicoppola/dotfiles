" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" Modified by: Steve Losh <steve@stevelosh.com>
" Modified by: Joe Copp <joe@cfxd.net>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

set background=dark
let g:colors_name="molokai"

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Basic Layout {{{
hi Normal          guifg=#F8F8F2 guibg=#060709
hi Folded          guifg=#666666 guibg=bg
hi CursorLine                    guibg=#232728
hi CursorColumn                  guibg=#232728
hi ColorColumn                   guibg=#232728
hi LineNr          guifg=#AAAAAA guibg=bg
hi FoldColumn      guifg=#AAAAAA guibg=bg
hi VertSplit       guifg=#AAAAAA guibg=bg gui=none
hi Search          guifg=#000000 guibg=#E4E500
hi IncSearch       guibg=#000000 guifg=#FF8D00
" }}}
" Syntax {{{
hi Boolean         guifg=#AE81FF
hi Comment         guifg=#5c7176
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi Float           guifg=#AE81FF
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
" }}}
" Diffs {{{
hi DiffAdd                       guibg=#0F1D0B
hi DiffChange      guifg=#89807D guibg=#322F2D
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4A4340 gui=italic,bold
" }}}
" Cursor {{{
hi Cursor          guifg=#000000 guibg=#F35FBC
hi iCursor         guifg=#000000 guibg=#FDFF00
hi vCursor         guifg=#000000 guibg=#AAF412
" }}}

hi EasyMotionTarget guifg=#E4E500 guibg=bg gui=bold
hi EasyMotionShade guifg=#444444 guibg=bg gui=bold
hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Ignore          guifg=#808080 guibg=bg

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#E4E400 guibg=#232728 gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" Completion Menu {{{
hi Pmenu           guifg=#cccccc guibg=#232728
hi PmenuSel        guifg=#000000 guibg=#AAF412
hi PmenuSbar                     guibg=#131414
hi PmenuThumb      guifg=#777777
" }}}

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold

" marks column
hi SignColumn      guifg=#A6E22E guibg=#151617
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
hi SpecialKey      guifg=#888A85               gui=italic
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#CD5907 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi MyTagListFileName guifg=#F92672 guibg=bg gui=bold

" Spelling {{{
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
" }}}
" Visual Mode {{{
hi VisualNOS  guibg=#403D3D
hi Visual     guibg=#403D3D
" }}}
" Invisible character colors {{{
highlight NonText    guifg=#444444 guibg=bg
highlight SpecialKey guifg=#444444 guibg=bg
" }}}

" MiniBufExpl Colors {{{
    hi MBEVisibleActive guifg=#A6DB29 guibg=fg
    hi MBEVisibleChangedActive guifg=#F1266F guibg=fg
    hi MBEVisibleChanged guifg=#F1266F guibg=fg
    hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
    hi MBEChanged guifg=#CD5907 guibg=fg
    hi MBENormal guifg=#808080 guibg=fg
" }}}

" Support for 256-color terminals {{{
if &t_Co > 255
    hi Boolean                  ctermfg=135
    hi Character                ctermfg=144
    hi Number                   ctermfg=135
    hi String                   ctermfg=144
    hi Conditional              ctermfg=161               cterm=bold
    hi Constant                 ctermfg=135               cterm=bold
    hi Cursor                   ctermfg=16   ctermbg=253
    hi Debug                    ctermfg=225               cterm=bold
    hi Define                   ctermfg=81
    hi Delimiter                ctermfg=241

    hi DiffAdd                               ctermbg=24
    hi DiffChange               ctermfg=181  ctermbg=239
    hi DiffDelete               ctermfg=162  ctermbg=53
    hi DiffText                              ctermbg=102  cterm=bold

    hi Directory                ctermfg=141               cterm=bold
    hi Error                    ctermfg=219  ctermbg=89
    hi ErrorMsg                 ctermfg=199  ctermbg=16   cterm=bold
    hi Exception                ctermfg=118               cterm=bold
    hi Float                    ctermfg=135
    hi FoldColumn               ctermfg=67   ctermbg=233
    hi Folded                   ctermfg=67   ctermbg=233
    hi Function                 ctermfg=118
    hi Identifier               ctermfg=208
    hi Ignore                   ctermfg=244  ctermbg=232
    hi IncSearch                ctermfg=193  ctermbg=16

    hi Keyword                  ctermfg=161               cterm=bold
    hi Label                    ctermfg=229               cterm=none
    hi Macro                    ctermfg=193
    hi SpecialKey               ctermfg=81
    hi MailHeaderEmail          ctermfg=3    ctermbg=233
    hi MailEmail                ctermfg=3    ctermbg=233

    hi MatchParen               ctermfg=16   ctermbg=208  cterm=bold
    hi ModeMsg                  ctermfg=229
    hi MoreMsg                  ctermfg=229
    hi Operator                 ctermfg=161

    " complete menu
    hi Pmenu                    ctermfg=81   ctermbg=235
    hi PmenuSel                              ctermbg=226
    hi PmenuSbar                             ctermbg=227
    hi PmenuThumb               ctermfg=81

    hi PreCondit                ctermfg=118               cterm=bold
    hi PreProc                  ctermfg=118
    hi Question                 ctermfg=81
    hi Repeat                   ctermfg=161               cterm=bold
    hi Search                   ctermfg=253  ctermbg=66

    " marks column
    hi SignColumn               ctermfg=118  ctermbg=235
    hi SpecialChar              ctermfg=161               cterm=bold
    hi SpecialComment           ctermfg=245               cterm=bold
    " ugly black bg for e.g. commands in `$(cmd |derp |blah)` so don't set bg at all
    "hi Special                  ctermfg=81   ctermbg=232
    hi Special                  ctermfg=81
    hi SpecialKey               ctermfg=245

    hi Statement                ctermfg=161               cterm=bold
    hi StatusLine               ctermfg=238  ctermbg=253
    hi StatusLineNC             ctermfg=244  ctermbg=232
    hi StorageClass             ctermfg=208
    hi Structure                ctermfg=81
    hi Tag                      ctermfg=161
    hi Title                    ctermfg=166
    hi Todo                     ctermfg=231  ctermbg=232  cterm=bold

    hi Typedef                  ctermfg=81
    hi Type                     ctermfg=81                cterm=none
    hi Underlined               ctermfg=244               cterm=underline

    hi VertSplit                ctermfg=244  ctermbg=232  cterm=bold
    hi VisualNOS                             ctermbg=238
    hi Visual                                ctermbg=235
    hi WarningMsg               ctermfg=231  ctermbg=238  cterm=bold
    hi WildMenu                 ctermfg=81   ctermbg=16

    hi Comment                  ctermfg=59
    hi CursorLine                            ctermbg=234  cterm=none
    hi CursorColumn                          ctermbg=234
    hi ColorColumn                           ctermbg=234
    hi LineNr                   ctermfg=250
    hi NonText                  ctermfg=240

    " MiniBufExpl Colors {{{
        hi MBENormal                ctermfg=238
        hi MBEChanged               ctermfg=202
        hi MBEVisibleNormal         ctermfg=39
        hi MBEVisibleChanged        ctermfg=200
        hi MBEVisibleActiveNormal   ctermfg=0    ctermbg=244
        hi MBEVisibleChangedActive  ctermfg=200
    " }}}

    " Uncooperational with terminals so commented out
    "hi Normal           ctermfg=252  ctermbg=233
    "hi LineNr           ctermfg=250  ctermbg=233
    "hi NonText          ctermfg=240  ctermbg=233
end
" }}}
