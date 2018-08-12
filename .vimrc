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


" theming plugins
Plugin 'vim-airline/vim-airline'            " airline menu footer
Plugin 'vim-airline/vim-airline-themes'     " airline themes
Plugin 'alessandroyorba/arcadia'            " color scheme
Plugin 'jacoborus/tender.vim'               " color scheme
Plugin 'dracula/vim'                        " color scheme

" file format support plugins
Plugin 'ledger/vim-ledger'                  " ledger support
Plugin 'pangloss/vim-javascript'            " js?
Plugin 'mxw/vim-jsx'                        " jsx support

" for distraction free writing mode
Plugin 'junegunn/goyo.vim'                  " minimal writing setup
Plugin 'gabrielelana/vim-markdown'          " nicer markdown formatting and enables folding

" general management
Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy searching - not sure it is better than :find * but worth trying
Plugin 'tomtom/tcomment_vim'                " easy commenting of code [gc to toggle commenting on highlighting line, or gcc to toggle comment on current line]
Plugin 'tpope/vim-surround'

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
set textwidth=79
set formatoptions=qrn1

" colors and stuff
colorscheme tender
set background=dark
set termguicolors

set fillchars+=vert:\         " no character marker used for vertical splits - requires theme with VertSplit bg set to accent bg


set clipboard=unnamed         " clipboard sharing with defualt OS

" stuff from steve losh
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode                  " true by default anyway
set showcmd
set hidden
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
set noexpandtab                 " use tabs and don't expand to spaces (optional)

" show tab characters as carets
set list
set listchars=tab:▸\ 


" ===============
" MOVE AND SEARCH
" ===============

set backspace=indent,eol,start  " backspace through everything in insert mode


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set showmatch                   " also used for highlighting matches as you type

set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" uses normal regex style, not vim style
nnoremap / /\v
vnoremap / /\v

set gdefault                    " applies substitutions globally on lines
nnoremap <leader><space> :noh<cr>

" move to matching bracket using tab key
nnoremap <tab> %
vnoremap <tab> %

" disable arrow keys in normal and insert mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" navigating files / tabs
nnoremap <bs> <c-^>

" ============
" PRODUCTIVITY
" ============
" makes semicolon behave as colon - adding reverse too messes up plugins
nnoremap ; :

" auto save when losing focus
au FocusLost * :wa

" strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


" =====================
" IMPROVE NETRW DISPLAY
" =====================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25


" =============
" FINDING FILES
" =============
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
set wildmode=longest:full,full

" now we can: hit tab to :find by partial match, use * to make it fuzzy
" :b lets us autocomplete any open buffer - eg :b sty will open styles.css if
" in buffer

" ========
" MARKDOWN
" ========
let g:markdown_enable_folding = 0         " enabled by switching to 1, but it auto folds everything and is a performance hit
" set foldlevelstart=99                     " don't auto fold on opening a file


" ================
" PLUGIN - AIRLINE
" ================

set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
set noshowmode




" ================
" PLUGIN - HLEDGER
" ================

let g:ledger_maxwidth = 80
let g:ledger_fillstring = '. . '
let g:ledger_detailed_first = 1
let g:ledger_fold_blanks = 1
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger



" ======================
" PLUGIN - INDENT GUIDES
" ======================

let g:indent_guides_enable_on_vim_startup = 1     " enable on startup
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3


" =============
" PLUGIN - GOYO
" =============

function! s:goyo_enter()

  " to make :q work as normal rather than just exit Goyo mode
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
