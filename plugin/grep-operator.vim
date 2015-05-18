"============TEST================================

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <leader>gp :set operatorfunc=<SID>GrepOperatorWithInput<cr>g@
vnoremap <leader>gp :<c-u>call <SID>GrepOperatorWithInput(visualmode())<cr>
nnoremap <leader>gr :call <SID>EasyGrep()<cr>
nnoremap <leader>ef :call <SID>EasyFind()<cr>

function! s:EasyGrep()
    
    let l:patterntogrep = shellescape(input('Input string to grep:'))
    let l:pathtogrep = input('Input path to grep:')
    if l:pathtogrep ==# ''
        let l:pathtogrep = './'
    endif

    silent execute "grep! -rsw " . l:patterntogrep . " " . l:pathtogrep

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

function! s:EasyFind()
    
    let l:filetofind = input('Input file to find:', '', 'file')
    let l:path = input('Input path to find:', '', 'file')
    if l:filetofind ==# ''
        echo "You need to input a file to find!"
        return
    endif
    if l:path ==# ''
        let l:path = '.'
    endif

    "execute "!find " . l:path . " -name " . l:filetofind
    let l:cmd = "find " . l:path . " -name " . l:filetofind

    """"""""""""""""""""""""""""""""
    let cmd_output = system(l:cmd)

    if cmd_output == ""
        echohl WarningMsg |
        \ echomsg "Error: File " . l:filetofind . " not found" |
        \ echohl None
        return
    endif

    let tmpfile = tempname()

    exe "redir! > " . tmpfile
    silent echon cmd_output
    redir END

    let old_efm = &efm
    set efm=%f

    if exists(":cgetfile")
	execute "silent! cgetfile " . tmpfile
    else
	execute "silent! cfile " . tmpfile
    endif

    let &efm = old_efm

    call delete(tmpfile)
    """"""""""""""""""""""""""""""""

    if g:quickfix_is_open == 0
        let g:quickfix_return_to_window = winnr()
        botright copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! s:GrepOperatorWithInput(type)
    let l:saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let l:input = input('Plz input grep path:')
    if l:input ==# ''
        let l:grepath = '.'
    else
        "FIXME: accept l:input as absolute or relative path according to if l:input starts with '/'
        let l:grepath = './' . l:input
    endif

    silent execute "grep! -rsw " . shellescape(@@) . " " . l:grepath
    if g:quickfix_is_open
        botright cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        botright copen
        let g:quickfix_is_open = 1
    endif

    let @@ = l:saved_unnamed_register
endfunction

function! s:GrepOperator(type)
    let l:saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -rsw " . shellescape(@@) . " ."
    if g:quickfix_is_open
        botright cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        botright copen
        let g:quickfix_is_open = 1
    endif

    let @@ = l:saved_unnamed_register
endfunction
