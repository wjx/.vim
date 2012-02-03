"============TEST================================

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <leader>gp :set operatorfunc=<SID>GrepOperatorWithInput<cr>g@
vnoremap <leader>gp :<c-u>call <SID>GrepOperatorWithInput(visualmode())<cr>

function! s:GrepOperatorWithInput(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let l:input = input('Plz Input Grep Path:')
    if l:input ==# ''
        l:input = '.'
    endif

    execute "grep! -rsw " . shellescape(@@) . " " . l:input
    if g:quickfix_is_open == 0
        botright copen
        let g:quickfix_is_open = 1
        execute g:quickfix_return_to_window . "wincmd w"
    endif

    let @@ = saved_unnamed_register
endfunction

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    execute "grep! -rsw " . shellescape(@@) . " ."
    if g:quickfix_is_open == 0
        botright copen
        let g:quickfix_is_open = 1
        execute g:quickfix_return_to_window . "wincmd w"
    endif

    let @@ = saved_unnamed_register
endfunction
