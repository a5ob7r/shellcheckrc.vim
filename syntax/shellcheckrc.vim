if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'shellcheckrc'

let s:save_cpoptions = &cpoptions
set cpoptions&

" syntax {{{
" disable, enable {{{
syntax region shellcheckrcDirective matchgroup=Statement start=/\<\(disable\|enable\)\ze=\i\+/ end=/$/ contains=shellcheckrcCheck,shellcheckrcEnum,shellcheckrcOptional,shellcheckrcComment
syntax match shellcheckrcCheck /\<SC[1-9]\d\{3}\>/ contained
syntax keyword shellcheckrcEnum all contained
syntax match shellcheckrcOptional /\<add-default-case\|avoid-nullary-conditions\|check-extra-masked-returns\|check-set-e-suppressed\|check-unassigned-uppercase\|deprecate-which\|quote-safe-variables\|require-double-brackets\|require-variable-braces\>/ contained
" }}}

" external-sources {{{
syntax region shellcheckrcDirective matchgroup=Statement start=/\<external-sources\>\ze=\i\+/ end=/$/ contains=shellcheckrcBoolean,shellcheckrcComment
syntax keyword shellcheckrcBoolean true false contained
" }}}

" source, source-path {{{
syntax region shellcheckrcDirective matchgroup=Statement start=/\<\(source\|source-path\)\ze=\i\+/ end=/$/ contains=shellcheckrcComment
" }}}

" shell {{{
syntax region shellcheckrcDirective matchgroup=Statement start=/\<shell\ze=\i\+/ end=/$/ contains=shellcheckrcSh,shellcheckrcComment
syntax keyword shellcheckrcSh sh bash dash ksh contained
" }}}

" Comment {{{
syntax match shellcheckrcComment excludenl /#.*$/ contains=shellcheckrcTodo,@Spell
syntax keyword shellcheckrcTodo TODO FIXME XXX NB NOTE contained
" }}}
" }}}

" highlight {{{
highlight default link shellcheckrcCheck Special
highlight default link shellcheckrcEnum Special
highlight default link shellcheckrcOptional Identifier
highlight default link shellcheckrcBoolean Boolean
highlight default link shellcheckrcSh Special
highlight default link shellcheckrcComment Comment
highlight default link shellcheckrcTodo Todo
" }}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: set expandtab tabstop=2 shiftwidth=2 foldmethod=marker :
