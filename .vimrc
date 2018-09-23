" =============
" INITIAL STUFF
" =============

set nocompatible              " removes the crap to make vim vi compatible
set modelines=0               " prevents some security exploits
filetype off                  " required for bundles



" =======================
" INIT & INSTALL PACKAGES
" =======================

set packpath^=~/.vim
packadd minpac

call minpac#init()

" To install or update plugins:
" call minpac#update()

" To uninstall unused plugins:
" call minpac#clean()

" color schemes
call minpac#add('dracula/vim')                        " color scheme
call minpac#add('lmintmate/blue-mood-vim')            " color scheme

" file format support plugins
call minpac#add('ledger/vim-ledger')                  " ledger support
call minpac#add('pangloss/vim-javascript')            " js?
call minpac#add('mxw/vim-jsx')                        " jsx support

" for distraction free writing mode
call minpac#add('junegunn/goyo.vim')                  " minimal writing setup
call minpac#add('gabrielelana/vim-markdown')          " nicer markdown formatting and enables folding

" general management
call minpac#add('tomtom/tcomment_vim')                " easy commenting of code [gc to toggle commenting on highlighting line, or gcc to toggle comment on current line]
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-vinegar')
call minpac#add('ctrlpvim/ctrlp.vim')

" not needed but makes things pretty and more like a modern text editor
call minpac#add('itchyny/lightline.vim')

" ================
" CHROME & MAIN UI
" ================

" change the cursor in different modes
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_SR = "\<Esc>]50;CursorShape=2\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"

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
colorscheme dracula
set background=dark
set termguicolors
set guifont=SF\ Mono:h14

set fillchars+=vert:\         " no character marker used for vertical splits - requires theme with VertSplit bg set to accent bg


set clipboard=unnamed         " clipboard sharing with defualt OS

" stuff from steve losh
set encoding=utf-8
set scrolloff=3
set autoindent
set noshowmode                  " true by default anyway
set showcmd
set hidden
set visualbell                " Vim will flash its screen instead of sounding a beep
set cursorline                " highlight the current line and update as the cursor moves
set ttyfast                   " prob on by default - helps scrolling performance
set backspace=indent,eol,start


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
" clears the last search highlights	
nnoremap <esc> :noh<return><esc>

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

" navigate using mouse
set mouse=a

" ============
" PRODUCTIVITY
" ============

" makes semicolon behave as colon - adding reverse too messes up plugins
nnoremap ; :

" remap leader key to space
let mapleader = "\<Space>"

" auto save when losing focus
au FocusLost * :wa

" strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


" ================
" SPLITS AND PANES
" ===============+

" makes moving between panes and splits simpler - control + direction only in one chord
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

" =====================
" IMPROVE NETRW DISPLAY
" =====================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25


" =============
" FINDING FILES
" =============

" Search recursively down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
set wildmode=longest:full,full

" ignore folders of certain names when searching
set wildignore+=**/node-modules/**
set wildignore+=**/.git/**

" now we can: hit tab to :find by partial match, use * to make it fuzzy
" :b lets us autocomplete any open buffer - eg :b sty will open styles.css if
" in buffer


" ========
" MARKDOWN
" ========

let g:markdown_enable_folding = 1         " enabled by switching to 1, but it auto folds everything and is a performance hit
" set foldlevelstart=99                     " don't auto fold on opening a file


" ===========
" STATUS LINE
" ===========

set laststatus=2
" ==================
" STATUS LINE CUSTOM
" ==================

" from https://cromwell-intl.com/open-source/vim-word-count.html
" let g:word_count=""
" function WordCount()
" 	return g:word_count
" endfunction
" function UpdateWordCount()
" 	let lnum = 1
" 	let n = 0
" 	while lnum <= line('$')
" 		let n = n + len(split(getline(lnum)))
" 		let lnum = lnum + 1
" 	endwhile
" 	let g:word_count = n
" endfunction

" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
" set updatetime=1000
" augroup WordCounter
" " 	au! CursorHold,CursorHoldI * call UpdateWordCount()
" " augroup END

" to get git branch
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?' |'.l:branchname.'|':''
" endfunction


" set statusline=
" set statusline+=%1*
" set statusline+=\ %n
" set statusline+=\ ›
" set statusline+=%{StatuslineGit()}
" set statusline+=%{ReadOnly()}
" set statusline+=\ %t 
" set statusline+=%m\ 
" set statusline+=%1*
" set statusline+=%=
" set statusline+=%1*
" set statusline+=\ %{WordCount()}\ words
" set statusline+=\ ::
" set statusline+=\ %P
" set statusline+=\ ::
" set statusline+=\ %c\ 

" function! ReadOnly() abort
"   if &readonly || !&modifiable
"     return ' 🔒'
"   else
"     return ''
" endfunction
"
" hi User1 guifg=#333333 guibg=#c40538
" hi User2 guifg=#666666 guibg=#333333


" ==================
" PLUGIN - LIGHTLINE
" ==================
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'percent', 'lineinfo', 'wordcount' ],
	\              [ 'filetype' ] ]
	\ },
	\ 'component_function': {
	\   'wordcount': 'WordCount',
	\ },
\ }

" ================
" PLUGIN - HLEDGER
" ================

let g:ledger_maxwidth = 80
let g:ledger_fillstring = '. . '
let g:ledger_detailed_first = 1
let g:ledger_fold_blanks = 1
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger



" ===============
" PLUGIN - CTRL P
" ===============

let g:ctrlp_working_path_mode = 0     " only search within current pwd
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

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


" =====================
" custom functions - wordcount
" =====================
" from: https://gist.github.com/cormacrelf/d0bee254f5630b0e93c3

function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction
