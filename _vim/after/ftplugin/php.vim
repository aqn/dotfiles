if exists('b:did_ftplugin_php')
  finish
endif
let b:did_ftplugin_php = 1

setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal nocindent
setlocal autoindent
setlocal smartindent
setlocal cinwords=if,elseif,else,for,switch,foreach,function,try,except,while,class

nnoremap _mak :make %<CR>

compiler php
autocmd BufWritePost * silent make %
