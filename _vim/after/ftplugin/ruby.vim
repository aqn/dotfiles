if exists('b:did_ftplugin_ruby')
  finish
endif
let b:did_ftplugin_ruby = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal autoindent
setlocal smartindent
setlocal number

setlocal foldmethod=syntax

" スペースでfoldingを開けると便利
nnoremap <buffer><space> za
