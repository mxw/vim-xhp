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

" Cleverly mix PHP and XML indentation.
fu! GetXhpIndent()
  let ind = GetPhpIndent()

  " Find the syntax at the end of the previous line.
  let lnum = prevnonblank(v:lnum - 1)
  let prevsyn = synIDattr(synID(lnum, strlen(getline(lnum)) - 1, 1), 'name')

  " Check for a PHP syntax error.  If the previous line was XHP, assume we are
  " also in XHP and use XML indenting.  If it wasn't, stick with our existing
  " PHP indentation.  This ensures that hitting <Enter> after the following:
  "
  "   $foo =
  "     <my:element
  "
  " does not reset the indentation of the second line to match the first,
  " while still preserving normal error behavior.
  if ind == -1
    if prevsyn =~ 'xml' || prevsyn =~ 'xhp'
      let ind = XmlIndentGet(v:lnum, 0)
    else
      let ind = indent(v:lnum)
    endif
  endif

  return ind
endfu
