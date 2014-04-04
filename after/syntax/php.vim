" Vim syntax file
" Language:     XHP (PHP)
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/vim-xhp
" Last Change:  April 4, 2014

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
  \ start=+<\@<!<\z([a-zA-Z0-9:\-]\+\)+
  \ skip=+<!--\_.\{-}-->+
  \ end=+</\z1\_\s\{-}>+
  \ end=+/>+
  \ contained
  \ keepend
  \ extend

" XHP attribute-safe PHP delimiters (i.e., not {}).
syn match xhpParent +[([\])]+ contained
hi def link xhpParent Delimiter

" XHP attributes and all tag content in {}'s should color as PHP.
syn region  xmlString contained start=+{+ end=+}+ contains=@phpClConst,xhpParent
syn region xhpContent contained start=+{+ end=+}+ contains=@phpClConst,xhpParent

" XHP keywords.
syn keyword xhpType enum contained
syn keyword xhpDeclare attribute category children contained
syn match xhpDecorator +@required+ contained

hi def link xhpType Type
hi def link xhpDeclare Structure

" Add xhpRegion and keywords to the lowest-level PHP syntax cluster.
syn cluster phpClConst add=xhpRegion,xhpType,xhpDeclare,xhpDecorator
