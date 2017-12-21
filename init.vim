" ==============================================================================
" System configuraiton
" ==============================================================================
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if g:os == "Windows" && !has('nvim')
    " Make windows use ~/.vim too, I don't want to use _vimfiles
    set runtimepath^=~/.vim
    cd ~
endif

if has('nvim') || g:os != "Windows"
    " use this file's directory as the parent for the plugin dir
    let g:plug_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/plugged'
else
    " resolve() works correct in Windows Neovim but not Windows Vim:
    " https://github.com/vim/vim/issues/147
    " use ~\.vim\plugged instead
    let g:plug_dir = $HOME . '\\.vim\\plugged'
endif

" ==============================================================================
" Plugins
" ==============================================================================
call plug#begin(g:plug_dir) " Make sure you use single quotes
    " Tools
    Plug 'vimwiki/vimwiki'              " Note taking
    Plug 'mattn/calendar-vim'           " Calendar; vimwiki uses for the diary
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
    " Misc
    Plug 'tpope/vim-sensible'           " 'Defaults everyone can agree on'

    if has('nvim')                      " Neovim specific
        " None for now
    else                                " Vim specific
        " Language support
        Plug 'OmniSharp/omnisharp-vim'  " Intellisense and more for C#
    endif
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
" Misc display settings
" ---------------------
set concealcursor = '' " don't conceal the cursor line

" ==============================================================================
" GUI settings
" ==============================================================================
set guioptions-=m  " menu bar
set guioptions-=T  " toolbar
set guioptions-=r  " scrollbar
set guioptions-=e  " tab bar
" Font
if has("gui_running")
    if g:os == "Linux"
        set guifont=Iosevka\ Regular\ 13
    elseif g:os == "Darwin"
        set guifont=Menlo\ Regular:h14
    elseif g:os == "Windows"
        " set guifont=Fantasque\ Sans\ Mono:h11
        " Windows GVim doesn't allow non-monospace fonts
        " set guifont=Iosevka:h12
        set guifont=Iosevka\ Term:h12,Consolas:h12,Fantasque\ Sans\ Mono:h12
    endif
endif
" Display whitespace
if g:os == "Windows"
    " Windows doesn't like unicode characters... use ascii instead
    " These are the same listchars provided by TPope's Vim-Sensible
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    " Windows' gvim doesn't open as unicde, so this will fail:
    " set showbreak=»
    " Instead, use this:
    let &showbreak="\u00bb\ "
else
    " alternative characters: ‣ · ↲ ⏎ ⟨⟩ «» ¬ ¶ ␣ …
    set listchars=tab:→\ ,trail:•,precedes:⟨,extends:⟩
    set showbreak=↪\ 
endif
set list

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
let work_wiki = {}
let ftdna_wiki = {}
let qaautomation_wiki = {}
let personal_wiki = {}
if g:os == 'Windows'
    let work_wiki.path = 'H:\work.wiki'
    let ftdna_wiki.path = 'H:\ftdna-qa-automation.wiki'
    let qaautomation_wiki.path = 'H:\qa-automation.wiki'
    let personal_wiki.path = 'H:\personal.wiki'
elseif g:os == 'Linux'
    let work_wiki.path =  '/mnt/h/work.wiki'
    let ftdna_wiki.path = '/mnt/h/ftdna-qa-automation.wiki'
    let personal_wiki.path = '/mnt/h/personal.wiki'
endif
let work_wiki.syntax = 'markdown'
let work_wiki.ext = '.md'
let personal_wiki.syntax = 'markdown'
let personal_wiki.ext = '.md'
let ftdna_wiki.syntax = 'markdown'
let ftdna_wiki.ext = '.md'
let ftdna_wiki.index = 'home'
let qaautomation_wiki.syntax = 'markdown'
let qaautomation_wiki.ext = '.md'
let qaautomation_wiki.index = 'home'

let g:vimwiki_list = [work_wiki, qaautomation_wiki, ftdna_wiki, personal_wiki]

let g:vimwiki_conceallevel = 2

autocmd FileType vimwiki map <leader>d :VimwikiMakeDiaryNote<CR>
autocmd FileType vimwiki map <leader>dg :VimwikiDiaryGenerateLinks<CR>
autocmd FileType vimwiki map <leader>di :VimwikiDiaryIndex<CR>
autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>

" indentLine overrides conceal settings and interferes with vimwiki
autocmd FileType vimwiki let g:indentLine_concealcursor = ''
autocmd FileType vimwiki let g:indentLine_conceallevel = 2
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
