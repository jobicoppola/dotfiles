" Vim color file
" Converted from Textmate theme SpaceCadet.jobi using Coloration v0.2.5 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "SpaceCadet.jobi"

hi Cursor  guifg=NONE guibg=#7f005d gui=NONE
hi Visual  guifg=NONE guibg=#40002f gui=NONE
hi CursorLine  guifg=NONE guibg=#0c0c0c gui=NONE
hi CursorColumn  guifg=NONE guibg=#0c0c0c gui=NONE
hi LineNr  guifg=#757a6e guibg=#0d0d0d gui=NONE
hi VertSplit  guifg=#353632 guibg=#353632 gui=NONE
hi MatchParen  guifg=#aec386 guibg=NONE gui=NONE
hi StatusLine  guifg=#dde6cf guibg=#353632 gui=bold
hi StatusLineNC  guifg=#dde6cf guibg=#353632 gui=NONE
hi Pmenu  guifg=#6a85d7 guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#40002f gui=NONE
hi IncSearch  guifg=NONE guibg=#2c3550 gui=NONE
hi Search  guifg=NONE guibg=#2c3550 gui=NONE
hi Directory  guifg=#d0a86e guibg=NONE gui=NONE
hi Folded  guifg=#473c45 guibg=#0d0d0d gui=NONE

hi Normal  guifg=#dde6cf guibg=#0d0d0d gui=NONE
hi Boolean  guifg=#d0a86e guibg=NONE gui=NONE
hi Character  guifg=#d0a86e guibg=NONE gui=NONE
hi Comment  guifg=#473c45 guibg=NONE gui=italic
hi Conditional  guifg=#aec386 guibg=NONE gui=NONE
hi Constant  guifg=#d0a86e guibg=NONE gui=NONE
hi Define  guifg=#aec386 guibg=NONE gui=NONE
hi ErrorMsg  guifg=NONE guibg=#5f0047 gui=NONE
hi WarningMsg  guifg=NONE guibg=#5f0047 gui=NONE
hi Float  guifg=#d0a86e guibg=NONE gui=NONE
hi Function  guifg=#6a85d7 guibg=NONE gui=NONE
hi Identifier  guifg=#b2d86c guibg=NONE gui=NONE
hi Keyword  guifg=#aec386 guibg=NONE gui=NONE
hi Label  guifg=#a5739a guibg=NONE gui=NONE
hi NonText  guifg=#bfbfbf guibg=#0c0c0c gui=NONE
hi Number  guifg=#d0a86e guibg=NONE gui=NONE
hi Operator  guifg=NONE guibg=NONE gui=NONE
hi PreProc  guifg=#aec386 guibg=NONE gui=NONE
hi Special  guifg=#dde6cf guibg=NONE gui=NONE
hi SpecialKey  guifg=#bfbfbf guibg=#0c0c0c gui=NONE
hi Statement  guifg=#aec386 guibg=NONE gui=NONE
hi StorageClass  guifg=#b2d86c guibg=NONE gui=NONE
hi String  guifg=#a5739a guibg=NONE gui=NONE
hi Tag  guifg=#6a85d7 guibg=NONE gui=NONE
hi Title  guifg=#dde6cf guibg=NONE gui=bold
hi Todo  guifg=#473c45 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=#6a85d7 guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#aec386 guibg=NONE gui=NONE
hi rubyFunction  guifg=#6a85d7 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#d0a86e guibg=NONE gui=NONE
hi rubyConstant  guifg=#c3657c guibg=NONE gui=NONE
hi rubyStringDelimiter  guifg=#a5739a guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=#7988af guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyInclude  guifg=#aec386 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#7988af guibg=NONE gui=NONE
hi rubyRegexp  guifg=#a5739a guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#a5739a guibg=NONE gui=NONE
hi rubyEscape  guifg=#d0a86e guibg=NONE gui=NONE
hi rubyControl  guifg=#aec386 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=NONE guibg=NONE gui=NONE
hi rubyException  guifg=#aec386 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#c3657c guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod  guifg=#c3657c guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#c3657c guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#c3657c guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#c3657c guibg=NONE gui=NONE
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#473c45 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#c3657c guibg=NONE gui=NONE
hi htmlTag  guifg=#6a85d7 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#6a85d7 guibg=NONE gui=NONE
hi htmlTagName  guifg=#6a85d7 guibg=NONE gui=NONE
hi htmlArg  guifg=#6a85d7 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#d0a86e guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#b2d86c guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#c3657c guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#6a85d7 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#7988af guibg=NONE gui=NONE
hi yamlAlias  guifg=#7988af guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#a5739a guibg=NONE gui=NONE
hi cssURL  guifg=#7988af guibg=NONE gui=NONE
hi cssFunctionName  guifg=#c3657c guibg=NONE gui=NONE
hi cssColor  guifg=#d0a86e guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#6a85d7 guibg=NONE gui=NONE
hi cssClassName  guifg=#6a85d7 guibg=NONE gui=NONE
hi cssValueLength  guifg=#d0a86e guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#c3657c guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
