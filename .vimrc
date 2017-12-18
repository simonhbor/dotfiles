" =============
" INITIAL STUFF
" =============

set nocompatible              " removes the crap to make vim vi compatible
set modelines=0               " prevents some security exploits
filetype off                  " required for bundles



" ======================
" INIT & INSTALL BUNDLES
" ======================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'alessandroyorba/arcadia'
Plugin 'ledger/vim-ledger'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'jacoborus/tender.vim' 
Plugin 'dracula/vim'
Plugin 'ctrlp.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" ================
" CHROME & MAIN UI
" ================

" change the cursor in different modes
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

" line numbers
set relativenumber            " lines above/below current shown relative to current
set number                    " current line set to actual file line number
set ruler                     " shows position information on right of bottom status line

syntax on

" line wrapping
set wrap
set linebreak

" colors and stuff
colorscheme dracula

" stuff from steve losh
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode                  " true by default anyway
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell                " Vim will flash its screen instead of sounding a beep
set cursorline                " highlight the current line and update as the cursor moves
set ttyfast                   " prob on by default - helps scrolling performance
set backspace=indent,eol,start
set laststatus=2


" =========
" TAB STOPS
" =========

set tabstop=2                   " a hard tab is x spaces
set softtabstop=2               " delete a tab deletes x spaces
set shiftwidth=2                " if exand to spaces, a tab is x spaces
set expandtab                   " use spaces, not tabs (optional)




" ===============
" MOVE AND SEARCH
" ===============

set backspace=indent,eol,start  " backspace through everything in insert mode


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" from steve losh
nnoremap / /\v
vnoremap / /\v
set gdefault
set showmatch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %


" =====================
" EXPLORE LIKE NERDTREE
" =====================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
 "  autocmd!
  " autocmd VimEnter * :Vexplore
  " augroup END



" ================
" PLUGIN - AIRLINE
" ================

set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
set noshowmode




" ================
" PLUGIN - HLEDGER
" ================

let g:ledger_maxwidth = 80
let g:ledger_fillstring = '. . '
let g:ledger_detailed_first = 1
let g:ledger_fold_blanks = 1
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

