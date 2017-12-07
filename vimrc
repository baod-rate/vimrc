" ==============================================================================
" System specific configuraiton
" ==============================================================================
if has('win32') || has('win64')
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
endif

" ==============================================================================
" Display
" ==============================================================================
" For VimWiki compatibility
set nocompatible
filetype plugin on
syntax on
" Use hybrid line numbers
set number relativenumber

" ==============================================================================
" Plugins
" ==============================================================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
    Plug 'vimwiki/vimwiki'
" Initialize plugin system
call plug#end()

" VimWiki
 let g:vimwiki_list = [
                        \{'path': 'H:/work.wiki'}
                \]
