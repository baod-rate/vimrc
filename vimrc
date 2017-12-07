" ==============================================================================
" System specific configuraiton
" ==============================================================================
if has('win32') || has('win64')
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
    cd ~
endif

" ==============================================================================
" Plugins
" ==============================================================================
call plug#begin('~/.vim/plugged') " Make sure you use single quotes
    " Tools
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    " Colorschemes
    Plug 'nightsense/vimspectr'
    Plug 'junegunn/seoul256.vim'
    " Display
    Plug 'itchyny/lightline.vim'
call plug#end()

" ==============================================================================
" Display
" ==============================================================================
" For VimWiki compatibility
" -------------------------
set nocompatible
filetype plugin on
syntax on
" Use hybrid line numbers
" -----------------------
set number relativenumber
" Colorscheme
" -----------
" let g:vimspectr60flat_dark_StatusLine = 'orange'
" colorscheme vimspectr60flat-dark " from vimspectr
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 235
colorscheme seoul256
" Font
" ----
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    " set guifont=Fantasque\ Sans\ Mono:h11
    set guifont=Iosevka:h11
  endif
endif
" GUI settings
" ------------
set guioptions-=m  " menu bar
set guioptions-=T  " toolbar
set guioptions-=r  " scrollbar
set guioptions-=e  " tab bar

" ==============================================================================
" Editing
" ==============================================================================
" Indentation
set tabstop=4     " tab size
set expandtab     " spaces instead of tabs
set shiftwidth=4  " indent at 4 spaces
set smartindent

" ==============================================================================
" Controls
" ==============================================================================
let mapleader="\'"
set mouse=a
" Insert time
" -----------
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" ==============================================================================
" Filetypes
" ==============================================================================
autocmd BufRead,BufNewFile *.wiki set filetype=vimwiki     " Vimwiki
autocmd BufNewFile,BufReadPost *.md set filetype=markdown  " Vim-markdown

" ==============================================================================
" Plugin oonfiguration
" ==============================================================================
call plug#begin('~/.vim/plugged') " Make sure you use single quotes
    " Tools
    Plug 'vimwiki/vimwiki'         " Note taking
    Plug 'mattn/calendar-vim'      " Calendar; vimwiki uses this for the diary
    " Colorschemes
    Plug 'nightsense/vimspectr'
    Plug 'junegunn/seoul256.vim'
    " Display
    Plug 'itchyny/lightline.vim'   " Statusbar
    " Utilities
    Plug 'tpope/vim-fugitive'      " Git wrapper; lightline uses this
    " Filetypes
    Plug 'tpope/vim-markdown'      " Markdown files
call plug#end()
" -------
" VimWiki
" -------
 let g:vimwiki_list = [
                        \{'path': 'H:/work.wiki',
			\'syntax' : 'markdown',
			\'ext': '.md'}
                \]
autocmd FileType vimwiki map <leader>d :VimwikiMakeDiaryNote<CR>
autocmd FileType vimwiki map <leader>dg :VimwikiDiaryGenerateLinks<CR>
autocmd FileType vimwiki map <leader>di :VimwikiDiaryIndex<CR>
autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>
" --------
" Calendar
" --------
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
" ---------
" Lightline
" ---------
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" ------------
" Vim-markdown
" ------------
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
