if exists('b:did_ftplugin_php')
  finish
endif
let b:did_ftplugin_php = 1

setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal cindent
setlocal cinwords=if,else,elseif,do,while,foreach,for,case,default,function,class,interface,abstract,private,public,protected,final
setlocal cinkeys=0{,0},0),!^F,o,O,e
map <space>m :make % <CR>

compiler php
set errorformat=%m\ in\ %f\ on\ line\ %l
"autocmd BufWritePost <buffer> silent make %
