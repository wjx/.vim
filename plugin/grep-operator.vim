"============TEST================================

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <leader>gp :set operatorfunc=<SID>GrepOperatorWithInput<cr>g@
vnoremap <leader>gp :<c-u>call <SID>GrepOperatorWithInput(visualmode())<cr>
nnoremap <leader>gr :call <SID>EasyGrep()<cr>

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
