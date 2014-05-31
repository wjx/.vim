" => General"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow

" Enable filetype plugin
filetype plugin on
filetype indent on

set cursorline

" Set to auto read when a file is changed from the outside
set autoread

set noswapfile

set modeline

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"see line837
" Fast saving
nmap <leader>w :w!<cr>

"TELL ME: why these don't work here,but work below?

" When vimrc is edited, reload it
"autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc
augroup sourcevimrc
    au!
    autocmd! bufwritepost vimrc source ~/.vimrc
augroup END
"}}}

" => VIM user interface"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"}}}

" => Colors and Fonts"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Configure System type
function! MySys() 
    return "linux" 
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif MySys() == "windows"
    set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
    set gfn=Monospace\ 12
    set shell=/bin/bash
endif

if has("gui_running")
    set guioptions-=T
    set t_Co=256
    set background=dark
    colorscheme blue
    "colorscheme delek
    "colorscheme evening
    "colorscheme murphy
    "colorscheme slate
    "colorscheme darkblue
    "colorscheme desert
    "colorscheme koehler
    "colorscheme pablo
    "colorscheme ron
    "colorscheme torte
    "colorscheme default
    "colorscheme elflord
    "colorscheme morning
    "colorscheme peachpuff
    "colorscheme shine
    "colorscheme zellner
    "colorscheme aqua
    set nonu
else
    "colorscheme blue
    "colorscheme delek
    "colorscheme evening
    "colorscheme murphy
    "colorscheme slate
    "colorscheme darkblue
    "colorscheme desert
    "colorscheme koehler
    "colorscheme pablo
    "colorscheme ron
    "colorscheme torte
    "colorscheme default
    "colorscheme elflord
    "colorscheme morning
    "colorscheme peachpuff
    "colorscheme shine
    "colorscheme zellner
    "colorscheme aqua
    colorscheme molokai
    set background=dark
    set t_Co=256
endif

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types
"}}}

set lbr
set tw=80

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
"}}}

" => Visual mode related"{{{
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
"}}}

" => Command mode related"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $v e ~/.vim/
"}}}

" => Moving around, tabs and buffers"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <S-space> ?
map <silent> <leader><cr> :noh<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Specify the behavior when switching between buffers 
try
    set switchbuf=usetab
    set stal=2
catch
endtry
"}}}

" => Statusline"{{{
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
"}}}

" => Parenthesis/bracket expanding"{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
"}}}

" => General Abbrevs"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"}}}

" => Cope"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
"map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
"}}}

""""Plugins"""""""""""""""""""""{{{
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplVSplit = 15
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

augroup uminibufexplorer
    au!
    autocmd BufRead,BufNew :call UMiniBufExplorer
augroup END

map <leader>u :TMiniBufExplorer<cr>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH
map <leader>b :Bgrep<cr>
map <leader>r :Rgrep<cr>

"---------For LookUpFile------------------
let g:LookupFile_TagExpr=string('./tagsForLookUpFile')

function! SetRootOfTheProject(path,project)
    exe 'cd '.a:path
    if a:project ==# 'android'
        exe '!genAndroidFileTags&&genAndroidCtagAndCscope'
    elseif a:project ==# 'general'
        exe '!genFileTags&&genCtagAndCscope'
    elseif a:project ==# 'kernel'
        exe '!genFileTags&&genKernelCtagAndCscope'
    endif
    let tagFilePath = genutils#CleanupFileName(a:path.'/tagsForLookUpFile')
    exe "let g:LookupFile_TagExpr='\"".tagFilePath."\"'"
    "ctags and cscope--------
    set tags=$PWD/tags

    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    "--------
endfunction
function! SetHereTheRoot(project)
    call SetRootOfTheProject('.',a:project)
endfunction
nmap <leader>acf :call SetHereTheRoot('android')<CR>
nmap <leader>cf :call SetHereTheRoot('general')<CR>
nmap <leader>kcf :call SetHereTheRoot('kernel')<CR>

function! SetSpecifiedPathTheRoot(project)
    call SetRootOfTheProject(input('Please Input Project root path:'),project)
endfunction
nmap <leader>axcf :call SetSpecifiedPathTheRoot('android')<CR>
nmap <leader>xcf :call SetSpecifiedPathTheRoot('general')<CR>

nmap <leader>o :LookupFile<CR>
"---------For LookUpFile------------------

nmap <leader>croot :!genCtagAndCscope

"=============================FOR CSCOPE======================================"{{{
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

"map :cstag
nnoremap <leader>ta :cstag 

nmap s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

nmap <C-Space><C-Space>s
            \ :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g
            \ :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c
            \ :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t
            \ :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e
            \ :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i
            \ :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d
            \ :vert scs find d <C-R>=expand("<cword>")<CR><CR>
"=============================END CSCOPE======================================
"}}}

"=============================FOR Fuf======================================"{{{
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> sK     :FufFileWithFullCwd<CR>
nnoremap <silent> s<C-k> :FufFile<CR>
nnoremap <silent> sl     :FufCoverageFileChange<CR>
nnoremap <silent> sL     :FufCoverageFileChange<CR>
nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> sD     :FufDirWithFullCwd<CR>
nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
nnoremap <silent> su     :FufBookmarkFile<CR>
nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> si     :FufBookmarkDir<CR>
nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> st     :FufTag<CR>
nnoremap <silent> sT     :FufTag!<CR>
nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> s,     :FufBufferTag<CR>
nnoremap <silent> s<     :FufBufferTag!<CR>
vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> s.     :FufBufferTagAll<CR>
nnoremap <silent> s>     :FufBufferTagAll!<CR>
vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> sg     :FufTaggedFile<CR>
nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
nnoremap <silent> sh     :FufHelp<CR>
nnoremap <silent> se     :FufEditDataFile<CR>
nnoremap <silent> sr     :FufRenewCache<CR>
"=============================FOR Fuf======================================
"}}}

"For MultipleSearch
let g:MultipleSearchMaxColors = 50
"}}}

" => Omni complete functions"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"}}}

" => MISC"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

set nu

set tags=$PWD/tags
set csto=1

"set cscopequickfix=s-,c-,d-,i-,t-,e-

"Fast edit .vimrc
nmap <F6> :e ~/.vimrc
map <F7> :so ~/.vimrc

"This doesn't work at line106 while works here,why???
" Fast saving
nmap <leader>w :w!<cr>

set guioptions-=T "get rid of toolbar
set guioptions-=m "get rid of menu

"Vertical diff
"This only work when start with gvimdiff/vimdiff
"if &diff
"set diffopt=vertical
"endif
nnoremap diff :TMiniBufExplorer<cr>:vert diffsplit 

"Toggle quickfix
nnoremap <silent> <c-x> :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        botright cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        botright copen
        let g:quickfix_is_open = 1
    endif
endfunction

"-------------cursor in terminal----------------
if has("autocmd")
    au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
endif

"-------------move cursor under insert mode----------------
"left
inoremap <silent> <C-h> <Left>
"down
inoremap <silent> <C-j> <Down>
"up
inoremap <silent> <C-k> <Up>
"right
inoremap <silent> <C-l> <Right>

"-------------walk through buffer-----------------------
nnoremap <silent> <C-j> :bn<cr>
nnoremap <silent> <C-k> :bp<cr>

"<BS> and <Delete>
inoremap <silent> <C-z> <BS>
inoremap <silent> <C-x> <Delete>

"Fast back to NORMAL from INSERT mode,and write file
inoremap jk <ESC>:w!<cr>

"Fast grep
"nnoremap <leader>g :silent execute "grep! -rsw " . shellescape("<cword>") . " ./"<cr>:copen<cr>

filetype plugin indent on
set completeopt=longest,menu

" VIMMMM script file settings---------------{{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
"}}}

"Add .vim/bin/ into PATH"{{{
augroup addPATH
    au!
    au VimEnter * let $PATH = $PATH . ':~/.vim/bin/'
augroup END
"}}}
nnoremap <leader>f /<c-r>"

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
"  (thanks Douglas Potts)
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

"Shift+L/R Mouse to search a word
set mousemodel=extend

"For clipboard
set clipboard=unnamed

"calendar
command! Cal Calendar
command! Calh CalendarH

set background=dark

"Operator Y/P,yank text into system clipboard
nnoremap Y :set operatorfunc=<SID>YOperator<cr>g@
vnoremap Y :<c-u>call <SID>YOperator(visualmode(), 1)<cr>
function! s:YOperator(type, ...)
    echom a:type
    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "normal! `<" . a:type . "`>\"+y"
    elseif a:type == 'line'
        silent exe "normal! '[V']\"+y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]\"+y"
    else
        silent exe "normal! `[v`]\"+y"
    endif
endfunction
nnoremap P "+p

"Go back to the start of visual selection and Search in it
"^_ == <C-/> in gnome-terminal
vnoremap  <esc>`</\%V

set fileencodings=utf-8,gbk,ucs-bom,cp936

execute pathogen#infect()

set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_max_files = 1000

"Search current c function in current file
nnoremap 8 :call CurrentFunc("j")<cr>
nnoremap 3 :call CurrentFunc("k")<cr>
func! CurrentFunc(key)
	"set mark at original position
	exec "normal mo"
	exec "normal ][%b%b"
	exec "normal \"syw"
	let @/ = @s
	if a:key == 'j'
		exec "normal *" 
	elseif a:key == 'k'
		exec "normal #"
	endif
endfunc " CurrentFunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       MISC END --- place MISC AT Last will have problem,why?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"}}}
"
