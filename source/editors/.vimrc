" vi compatible mode is disabled
set nocompatible

" =====================================================================
" Syntax and indent
" =====================================================================

" enable syntax processing
syntax on

" indent
filetype indent on      " load filetype-specific indent files

" =====================================================================
" Basic Config 
" =====================================================================

" UI Config
set number            " show line numbers
set relativenumber    " show relative numbering
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set ruler               " show ruler
filetype plugin on      " load filetype specific plugin files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set laststatus=2        " Show the status line at the bottom
set mouse+=a            " A necessary evil, mouse support
set noerrorbells visualbell t_vb=    "Disable annoying error noises
set splitbelow          " Open new vertical split bottom
set splitright          " Open new horizontal splits right
" set columns=80          " set 80 columns
set colorcolumn=80      " highlight 80 columns
set linebreak           " Have lines wrap instead of continue off-screen
set scrolloff=12        " Keep cursor in approximately the middle of the screen
set updatetime=100      " Some plugins require fast updatetime
set ttyfast             " Improve redrawing
set history=8192        " more history
set nobackup            " no backup files
set noswapfile          " no swap files
set autochdir           " change to the directory of the file you opened
set hlsearch            " highlight the search keyword
highlight Comment ctermfg=green

" indent
set tabstop=2           " number of visual spaces per tab
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " Insert 4 spaces on a tab
set expandtab           " Use spaces instead of tab
" Copy indent from current line when starting a new line 
" set autoindent

" Buffers
set hidden         " Allows having hidden buffers (not displayed in any window)

" =====================================================================
" Lose Bad Habits
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
" =====================================================================

" Remove newbie crutches in Command Mode
" cnoremap <Down> <Nop>
" cnoremap <Left> <Nop>
" cnoremap <Right> <Nop>
" cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Enable hard home so hjkl are disabled
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Filetype configs
" Jinja yml (mostly for Ansible) gets linted as yaml
autocmd BufNewFile,BufRead *.yml.j2 set syntax=yaml

" =====================================================================
" Plugin Config 
" =====================================================================

" plugins setting and keyboard shortcut

" NERDTree
let g:NERDTreeWinSize = 20
let g:tagbar_width = 20
map <C-d> : NERDTreeToggle<CR>

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" NERDCommenter
let g:mapleader = ','
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" =============================================================================
" Custom Functions
" =============================================================================

" toggle between number and relativenumber
function! ToggleLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction