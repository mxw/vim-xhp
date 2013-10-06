vim-xhp
=======

Syntax highlighting and indenting for XHP.  XHP is a PHP extension developed by
Facebook which augments PHP with inline XML documents and custom XML elements.

Installation
------------

### Pathogen

The recommended installation method is via [Pathogen][1].  Then simply execute

    cd ~/.vim/bundle
    git clone https://github.com/mxw/vim-xhp.git

### Manual Installation

If you have no `~/.vim/after` directory, you can download a tarball or zip from
GitHub and copy the contents to `~/.vim`.

If you have existing `~/.vim/after` files, copy the syntax and indent files
directly into their respective destinations.  If you have existing after syntax
or indent files for PHP, you'll probably want to do something like

    mkdir -p ~/.vim/after/syntax/php
    cp path/to/vim-xhp/after/syntax/php.vim ~/.vim/after/syntax/php/xhp.vim
    mkdir -p ~/.vim/after/indent/php
    cp path/to/vim-xhp/after/indent/php.vim ~/.vim/after/indent/php/xhp.vim


[1]: https://github.com/tpope/vim-pathogen      "tpope: vim-pathogen"
