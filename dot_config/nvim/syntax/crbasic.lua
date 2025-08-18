" crbasic.vim - Syntax highlighting for CRBasic
if exists("b:current_syntax")
  finish
endif

" Comments
syntax match crbasicComment "\'.*$"
highlight link crbasicComment Comment

" Strings
syntax region crbasicString start=+"+ skip=+\\.+ end=+"+
highlight link crbasicString String

" Numbers
syntax match crbasicNumber "\<\d\+\(\.\d\+\)\?\([eE][+-]\=\d\+\)\?\>"
highlight link crbasicNumber Number

" Keywords
syntax keyword crbasicKeyword If Then Else End EndIf For Next While Wend Call Return
highlight link crbasicKeyword Keyword

" Functions (customize based on CRBasic functions)
syntax keyword crbasicFunction Public Const Alias Units DataTable Sample Interval
highlight link crbasicFunction Function

" Types
syntax keyword crbasicType Float Integer Boolean String
highlight link crbasicType Type

let b:current_syntax = "crbasic"
