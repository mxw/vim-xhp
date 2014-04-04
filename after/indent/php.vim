" Vim indent file
" Language:     XHP (PHP)
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/vim-xhp
" Last Change:  April 4, 2014

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

  " Check for a PHP syntax error.
  if ind == -1
    " Get all syntax items for the end of the previous line.
    let lnum = prevnonblank(v:lnum - 1)
    let col = strlen(getline(lnum)) - 1
    let prevsyn = map(synstack(lnum, col), 'synIDattr(v:val, "name")')

    " Keep only the XHP and XML items.
    let xhpsyn = filter(prevsyn, 'v:val =~ "xml" || v:val =~ "xhp"')

    " If the previous line ended with XHP, assume we are still in XHP and use
    " XML indenting; otherwise, stick with the existing PHP indentation.  This
    " ensures that hitting an indentkey after the following:
    "
    "   $foo =
    "     <my:element
    "
    " does not reset the indentation of the second line to match the first.
    if !empty(xhpsyn)
      let ind = XmlIndentGet(v:lnum, 0)

      " Align '/>' with '<' for multiline self-closing tags.
      if getline(v:lnum) =~? '^\s*\/>\s*;\='
        let ind = ind - &sw
      endif

      " Then correct the indentation of the line following '/>'.
      if getline(v:lnum - 1) =~? '^\s*\/>\s*;\='
        let ind = ind + &sw
      endif
    else
      let ind = indent(v:lnum)
    endif
  endif

  return ind
endfu
