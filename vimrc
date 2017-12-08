" ==============================================================================
" System specific configuraiton
" ==============================================================================
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if g:os == "Windows"
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
    cd ~
endif

" ==============================================================================
" Plugins
" ==============================================================================
call plug#begin('~/.vim/plugged') " Make sure you use single quotes
    " Tools
    Plug 'vimwiki/vimwiki'              " Note taking
    Plug 'mattn/calendar-vim'           " Calendar; vimwiki uses this for the diary
    " Colorschemes
    Plug 'nightsense/vimspectr'
    Plug 'junegunn/seoul256.vim'
    " Display
    Plug 'itchyny/lightline.vim'        " Statusbar
    Plug 'Yggdroot/indentLine'          " Indentation level guides
    " Utilities
    Plug 'tpope/vim-fugitive'           " Git wrapper; lightline uses this
    Plug 'tpope/vim-dispatch'           " asynchronous build; for OmniSharp
    Plug 'Shougo/vimproc.vim'           " asynchronous commands; for OmniSharp
    " Filetypes
    Plug 'tpope/vim-markdown'           " Markdown files
    " Editing
    Plug 'vim-syntastic/syntastic'      " Syntax checking
    Plug 'AndrewRadev/splitjoin.vim'    " Transition Single<->Multi-line code
    " Language support
    Plug 'OmniSharp/omnisharp-vim'      " Intellisense and more for C#
    " Misc
    Plug 'tpope/vim-sensible'           " 'Defaults everyone can agree on'
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
    if g:os == "Linux"
        set guifont=Iosevka\ Regular\ 13
    elseif g:os == "Darwin"
        set guifont=Menlo\ Regular:h14
    elseif g:os == "Windows"
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
" Display whitespace
" ------------------
set listchars=tab:»\ ,trail:¬,nbsp:·

" ==============================================================================
" Behavior
" ==============================================================================
" case insensitive search (unless search terms contain uppercase characters)
set ignorecase
set smartcase

" ==============================================================================
" Editing
" ==============================================================================
" Indentation
set tabstop=4     " tab size
set expandtab     " spaces instead of tabs
set shiftwidth=4  " indent at 4 spaces
set softtabstop=4 " backspace 4 spaces
set smartindent

" ==============================================================================
" Mappings
" ==============================================================================
" Leader
" ------
let mapleader="\<Space>"
" Window controls
" ---------------
nnoremap <silent> \ <C-W>
" Folding
" -------
nnoremap <leader><Space> za
" Enable mouse in terminal mode
" -----------------------------
set mouse=a
" Make Y behave like D and C
" --------------------------
:map Y y$
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
" -------
" VimWiki
" -------
if g:os == 'Windows'
    let g:vimwiki_list = [
                            \{'path': 'H:/work.wiki',
                            \'syntax' : 'markdown',
                            \'ext': '.md'}
                    \]
elseif g:os == 'Linux'
    let g:vimwiki_list = [
                            \{'path': '/mnt/h/work.wiki',
                            \'syntax' : 'markdown',
                            \'ext': '.md'}
                    \]
endif
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
" ---------
" Syntastic
" ---------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
