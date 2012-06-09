"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: XHP (PHP)
" Author: Max Wang <mxawng@gmail.com>
"
" CREDITS: Inspired by Facebook.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prologue; load in XML syntax.
if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XMLSyntax syntax/xml.vim
if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

" Highlight XHP regions as XML; recursively match.
syn region  xhpRegion contains=@XMLSyntax,xhpRegion,xhpContent
	\ start=+<\z([^ /!?<>"']\+\)+
	\ skip=+<!--\_.\{-}-->+
	\ end=+</\z1\_\s\{-}>+
	\ end=+/>+
  \ contained
	\ keepend
	\ extend

" XHP attribute-safe PHP delimiters (i.e., not {}).
syn region  xhpParent contains=@phpClInside
  \ matchgroup=Delimiter
  \ start="("
  \ end=")"
  \ contained
  \ transparent
syn region  xhpParent contains=@phpClInside
  \ matchgroup=Delimiter
  \ start="\["
  \ end="\]"
  \ contained
  \ transparent

" XHP attributes and all tag content in {}'s should color as PHP.
syn region  xmlString contained start=+{+ end=+}+ contains=@phpClConst,xhpParent
syn region xhpContent contained start=+{+ end=+}+ contains=@phpClConst,xhpParent

" Add xhpRegion to the lowest-level PHP syntax cluster.
syn cluster phpClConst add=xhpRegion

" Highlight yield as return.
syn keyword phpStatement yield contained
