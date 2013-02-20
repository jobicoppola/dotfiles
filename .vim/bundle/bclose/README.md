bclose.vim
==========

This plugin will delete buffer while keeping window layout -
i.e. it will not close the buffer's windows, and instead will
keep your layout as it was before. When using NERDTree along
with MiniBufExpl, doing a `:bd` to close a buffer would lead
to the window being closed as well, such that the next file
you opened would e.g. open on the bottom half and jack up
the entire layout.

Installation
------------

Either copy the script into your plugin dir:

    cp bclose.vim ~/.vim/plugin/

Or if you are using [pathogen.vim](https://github.com/tpope/vim-pathogen),
you can add the script as a bundle and have pathogen load it for you:

    mkdir -p ~/.vim/bundle/bclose/plugin
    cp blose.vim !$

Restart `vim` and you should be able to use the plugin to help
keep your window layout sane:

    :Bclose
    <leader>bd

Good hunting!
