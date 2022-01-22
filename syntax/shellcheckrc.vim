if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'shellcheckrc'

let s:save_cpoptions = &cpoptions
set cpoptions&

" syntax {{{
" general {{{
syntax match shellcheckrcAssign /\i\+\zs=\ze\i*/ contained
" }}}

" disable, enable {{{
syntax match shellcheckrcDirective /\<\%(disable\|enable\)\ze=/ nextgroup=shellcheckrcAssignDisableEnable
syntax region shellcheckrcAssignDisableEnable start=/=\ze\S/ end='$' contains=shellcheckrcCheck,shellcheckrcCheckSeparator,shellcheckrcEnum,shellcheckrcOptional,shellcheckrcComment contained

syntax match shellcheckrcCheck /\<\%(SC\)\=[1-9]\d\{3}\>/ contained
syntax match shellcheckrcCheckSeparator /,\|-/ contained
syntax keyword shellcheckrcEnum all contained
syntax match shellcheckrcOptional /\<add-default-case\|avoid-nullary-conditions\|check-extra-masked-returns\|check-set-e-suppressed\|check-unassigned-uppercase\|deprecate-which\|quote-safe-variables\|require-double-brackets\|require-variable-braces\>/ contained
" }}}

" external-sources {{{
syntax match shellcheckrcDirective /\<external-sources\>\ze=/ nextgroup=shellcheckrcAssignExternalSources
syntax region shellcheckrcAssignExternalSources start=/=\ze\S/ end=/$/ contains=shellcheckrcBoolean,shellcheckrcComment contained

syntax keyword shellcheckrcBoolean true false contained
" }}}

" source, source-path {{{
syntax match shellcheckrcDirective /\<\%(source\|source-path\)\ze=/ nextgroup=shellcheckrcAssignSourcePath
syntax region shellcheckrcAssignSourcePath start=/=\ze\S/ end=/$/ contains=shellcheckrcPath,shellcheckrcComment contained

syntax match shellcheckrcPath /\<\%([^[:space:]#]\|\\\s\|\\#\)\+/ contained
" }}}

" shell {{{
syntax match shellcheckrcDirective /\<shell\ze=/ nextgroup=shellcheckrcAssignShell
syntax region shellcheckrcAssignShell start=/=\ze\S/ end=/$/ contains=shellcheckrcSh,shellcheckrcComment contained

syntax keyword shellcheckrcSh sh bash dash ksh contained
" }}}

" Comment {{{
syntax match shellcheckrcComment excludenl /#.*$/ contains=shellcheckrcTodo,@Spell
syntax keyword shellcheckrcTodo TODO FIXME XXX NB NOTE contained
" }}}
" }}}

" highlight {{{
highlight default link shellcheckrcAssign NONE
highlight default link shellcheckrcAssignDisableEnable shellcheckrcAssign
highlight default link shellcheckrcAssignExternalSources shellcheckrcAssign
highlight default link shellcheckrcAssignSourcePath shellcheckrcAssign
highlight default link shellcheckrcAssignShell shellcheckrcAssign
highlight default link shellcheckrcDirective Statement
highlight default link shellcheckrcCheck Special
highlight default link shellcheckrcCheckSeparator NONE
highlight default link shellcheckrcEnum Special
highlight default link shellcheckrcOptional Identifier
highlight default link shellcheckrcBoolean Boolean
highlight default link shellcheckrcPath NONE
highlight default link shellcheckrcSh Special
highlight default link shellcheckrcComment Comment
highlight default link shellcheckrcTodo Todo
" }}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: set expandtab tabstop=2 shiftwidth=2 foldmethod=marker :
