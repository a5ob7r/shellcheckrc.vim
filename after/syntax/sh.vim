if get(b:, 'shellcheck_directive_highlight', get(g:, 'shellcheck_directive_highlight', 0))
  let s:save_current_syntax = b:current_syntax
  unlet! b:current_syntax
  syntax include @Shellcheckrc syntax/shellcheckrc.vim
  let b:current_syntax = s:save_current_syntax
  unlet! s:save_current_syntax

  syntax cluster shCommentGroup add=shShellcheckDirective
  syntax region shShellcheckDirective matchgroup=shShellcheckDirectiveStart start=/#\s*\zsshellcheck\ze\s\+/ end=/$/ contains=@Shellcheckrc keepend contained

  " Mimic shell shebang highlighting.
  highlight default link shShellcheckDirectiveStart PreProc
endif
