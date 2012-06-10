"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: XHP (PHP)
" Author: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prologue; load in XML indentation.
if exists('b:did_indent')
  let s:did_indent=b:did_indent
  unlet b:did_indent
endif
exe 'runtime! indent/xml.vim'
if exists('s:did_indent')
  let b:did_indent=s:did_indent
endif

setlocal indentexpr=GetXhpIndent()

" PHP indentkeys
setlocal indentkeys=0{,0},0),:,!^F,o,O,e,*<Return>,=?>,=<?,=*/
" XML indentkeys
setlocal indentkeys+=<>>,<<>,/,{,}

" Use either PHP or XML indentation, whichever is appropriate.
fu! GetXhpIndent()
  let ind = GetPhpIndent()
  if ind == -1
    let ind = XmlIndentGet(v:lnum,0)
  endif
  return ind
endfu
