if exists('b:did_ftplugin_python')
  finish
endif
let b:did_ftplugin_python = 1

setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal autoindent
setlocal smartindent
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

setlocal number
setlocal completeopt-=preview

nnoremap <buffer><space> za
