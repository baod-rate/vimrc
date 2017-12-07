" System specific configuraiton
if has('win32') || has('win64')
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
endif
" Use hybrid numbers (absolute on current line, relative elsewhere)
set number relativenumber

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
    Plug 'vimwiki/vimwiki'
" Initialize plugin system
call plug#end()
