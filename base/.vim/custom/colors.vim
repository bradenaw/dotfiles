highlight TabLineFill             ctermfg=Black       ctermbg=Black       cterm=None
highlight TabLine                 ctermfg=DarkGray    ctermbg=Black       cterm=None
highlight TabLineNum              ctermfg=Yellow      ctermbg=Black       cterm=None
highlight TabLineSel              ctermfg=White       ctermbg=None        cterm=None
highlight TabLineSelFaded         ctermfg=DarkGray    ctermbg=None        cterm=None
highlight TabLineNumSel           ctermfg=LightBlue   ctermbg=None        cterm=None
highlight TabLineMore             ctermfg=Black       ctermbg=Yellow      cterm=None

highlight LineNr                  ctermfg=DarkGray    ctermbg=Black
highlight CursorLine                                  ctermbg=Black       cterm=None
highlight CursorLineNr            ctermfg=White       ctermbg=Black
highlight ColorColumn                                 ctermbg=Black
highlight NonText                 ctermfg=White       ctermbg=Black
highlight SpecialKey              ctermfg=Black       ctermbg=None
highlight SignColumn                                  ctermbg=Black       cterm=None
highlight GitGutterAdd            ctermfg=DarkGreen   ctermbg=DarkGreen   cterm=None
highlight GitGutterChange         ctermfg=Yellow      ctermbg=Yellow      cterm=None
highlight GitGutterDelete         ctermfg=DarkRed     ctermbg=Black       cterm=None
highlight GitGutterChangeDelete   ctermfg=DarkRed     ctermbg=Yellow      cterm=None
highlight SignatureMarkText       ctermfg=White       ctermbg=DarkBlue
highlight SignatureMarkerText     ctermfg=White       ctermbg=DarkBlue
highlight Search                  ctermfg=Black       ctermbg=Yellow
highlight Identifier              ctermfg=None                            cterm=None

highlight IndentGuidesOdd                             ctermbg=None
highlight IndentGuidesEven                            ctermbg=Black

highlight PreProc                 ctermfg=DarkGray
highlight Constant                ctermfg=DarkMagenta
highlight Comment                 ctermfg=DarkCyan                        cterm=Reverse
highlight Operator                ctermfg=DarkGray
highlight Statement               ctermfg=Brown
highlight Type                    ctermfg=DarkGreen
highlight Pmenu                   ctermfg=None        ctermbg=Black       cterm=None

" Java
highlight javaCommentTitle        ctermfg=DarkBlue    ctermbg=None        cterm=Reverse
highlight javaDocComment          ctermfg=Blue        ctermbg=None        cterm=None
highlight javaDocParam            ctermfg=Magenta     ctermbg=None        cterm=None
highlight javaDocTags             ctermfg=DarkCyan    ctermbg=None        cterm=None
highlight javaString              ctermfg=Magenta
highlight javaParen               ctermfg=LightCyan
highlight javaParenT              ctermfg=LightCyan
highlight javaParen1              ctermfg=LightRed
highlight javaParenT1             ctermfg=LightRed
highlight javaParen2              ctermfg=LightBlue
highlight javaParenT2             ctermfg=LightBlue
highlight javaObject              ctermfg=DarkBlue
highlight javaConstantName        ctermfg=LightRed

" JavaScript
highlight javaScriptBraces        ctermfg=DarkGray
highlight javaScriptEmbed         ctermfg=Gray
highlight javaScriptFunction      ctermfg=DarkGreen
highlight javaScriptIdentifier    ctermfg=DarkGreen
highlight javaScriptNumber        ctermfg=DarkMagenta
highlight javaScriptParens        ctermfg=DarkGray
highlight javaScriptRegexpString  ctermfg=Blue
highlight javaScriptSpecial       ctermfg=DarkMagenta
highlight javaScriptStringD       ctermfg=Magenta
highlight javaScriptStringS       ctermfg=Magenta
highlight javaScriptStringT       ctermfg=Magenta
" For JavaScript embedded in HTML script tags.
highlight javaScript              ctermfg=None

" TypeScript
highlight typescriptCastKeyword   ctermfg=Yellow
highlight typescriptDocComment    ctermfg=DarkMagenta ctermbg=None       cterm=Reverse
highlight typescriptDocParam      ctermfg=White       ctermbg=DarkMagenta
highlight typescriptDocTags       ctermfg=Magenta     ctermbg=DarkMagenta
highlight typescriptExport        ctermfg=DarkYellow
highlight typescriptImport        ctermfg=DarkYellow
highlight typescriptNull          ctermfg=DarkMagenta
highlight typescriptObjectLabel   ctermfg=LightBlue
highlight typescriptOperator      ctermfg=DarkYellow
highlight typescriptString        ctermfg=Magenta
highlight typescriptStringD       ctermfg=Magenta
highlight typescriptStringS       ctermfg=Magenta
highlight typescriptStringB       ctermfg=Magenta
highlight typescriptFuncType      ctermfg=None
highlight typescriptInterpolationDelimiter ctermfg=DarkBlue
highlight typescriptBOMHistoryProp ctermfg=None
highlight typescriptGlobalObjects ctermfg=DarkGreen

" JSON
highlight jsonBraces              ctermfg=None

" Python
highlight pythonString            ctermfg=Magenta
highlight pythonBuiltin           ctermfg=DarkMagenta
highlight pythonFunction          ctermfg=DarkGreen

" HTML
highlight htmlTag                 ctermfg=DarkGray
highlight htmlEndTag              ctermfg=DarkGray
highlight htmlEvent               ctermfg=LightBlue

" Proto
highlight pbString                ctermfg=Magenta

" Go
highlight goString                ctermfg=Magenta
highlight goFormatSpecifier       ctermfg=DarkBlue
highlight goBuiltins              ctermfg=LightBlue
highlight goType                  ctermfg=DarkGreen

" Rust
highlight rustCommentLineDoc      ctermfg=DarkMagenta                     cterm=Reverse
highlight rustEnumVariant         ctermfg=DarkCyan
highlight rustEscape              ctermfg=DarkMagenta
syn match rustFormatSpecifier /[{}]/ contained containedin=rustString
highlight rustFormatSpecifier     ctermfg=DarkBlue
highlight rustFuncCall            ctermfg=None
highlight rustFuncName            ctermfg=None
highlight rustIdentifier          ctermfg=None
highlight rustLabel               ctermfg=DarkBlue
highlight rustLifetime            ctermfg=Yellow
highlight rustMacro               ctermfg=LightBlue
highlight rustModPathSep          ctermfg=DarkGray
highlight rustPubScopeDelim       ctermfg=DarkGray
highlight rustQuestionMark        ctermfg=Red                             cterm=None
highlight rustSelf                ctermfg=Gray
highlight rustSigil               ctermfg=LightBlue
highlight rustStorage             ctermfg=LightBlue
highlight rustString              ctermfg=LightMagenta

" sh
highlight shDerefSimple           ctermfg=LightBlue
highlight shDerefVar              ctermfg=LightBlue
highlight shDoubleQuote           ctermfg=Magenta
highlight shFunction              ctermfg=None
highlight shFunctionKey           ctermfg=DarkGreen
highlight shOption                ctermfg=DarkMagenta
highlight shQuote                 ctermfg=Magenta
highlight shTestDoubleQuote       ctermfg=Magenta
highlight shVariable              ctermfg=DarkBlue

" yaml
highlight yamlFlowIndicator       ctermfg=DarkGray
highlight yamlFlowString          ctermfg=LightMagenta
highlight yamlKeyValueDelimiter   ctermfg=DarkGray

" zsh
highlight zshString               ctermfg=LightMagenta

" markdown
highlight markdownH1              ctermfg=White
highlight markdownH1Delimiter     ctermfg=Gray
highlight markdownH2              ctermfg=White
highlight markdownH2Delimiter     ctermfg=Gray
highlight markdownH3Delimiter     ctermfg=Gray
highlight markdownCode            ctermfg=LightBlue
highlight markdownCodeDelimiter   ctermfg=DarkBlue
highlight markdownLinkText        ctermfg=LightCyan
highlight markdownUrl             ctermfg=DarkCyan
highlight markdownItalic          ctermfg=LightBlue
highlight markdownBold            ctermfg=White

highlight DiffAdd                 ctermfg=White       ctermbg=DarkGreen   cterm=None
highlight DiffDelete              ctermfg=White       ctermbg=DarkRed     cterm=None
highlight DiffChange              ctermfg=DarkGray    ctermbg=Yellow      cterm=None
highlight DiffText                ctermfg=White       ctermbg=DarkGreen   cterm=None

highlight trailingWhitespace                          ctermbg=DarkRed
highlight ExtraWhitespace                             ctermbg=DarkRed
match ExtraWhitespace /\s\+$/

highlight StatusLine              ctermfg=White       ctermbg=DarkYellow  cterm=None
highlight StatusLineFaded         ctermfg=Yellow      ctermbg=DarkYellow  cterm=None
highlight StatusLineNC            ctermfg=White       ctermbg=DarkGray    cterm=None
highlight StatusLineNCFaded       ctermfg=None        ctermbg=DarkGray    cterm=None
highlight StatusLinePosition      ctermfg=White       ctermbg=DarkGray    cterm=None
highlight StatusLinePositionFaded ctermfg=None        ctermbg=DarkGray    cterm=None
highlight VertSplit               ctermfg=DarkGray    ctermbg=DarkGray    cterm=None

highlight MatchParen              ctermfg=White       ctermbg=Blue        cterm=None
highlight TagbarSignature         ctermfg=DarkBlue
