" Liste tous les fichiers enregistrer depuis vi
" remplir automatiquement le fichier ~/vim/recent_files
" avec les nom des fichiers, la date et l'heure d'enregistrement

function! AddToRecentFiles()
    silent exec ':!$HOME/bin/recent.py $PWD/%'
endfunction

function! OptionFiles()
    "let file = bufname("%")
    if bufname("%")=="recent_files"
        map <Enter> gf
        set number
        set noswapfile
    else
        set nonumber
        set swapfile
        if hasmapto('gf')
            unmap gf
        endif
    endif
endfunction

if bufnr("$")==1 && bufname("$")==""
    silent edit ~/.vim/recent_files
    "setlocal number noswapfile
endif

command Recent edit ~/.vim/recent_files
cabbrev recent Recent

autocmd BufWritePost * :call AddToRecentFiles()
autocmd BufEnter * :call OptionFiles()
