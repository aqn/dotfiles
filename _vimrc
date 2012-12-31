set nocompatible
"----------------------------------------------------------------------------
" neobundle
"----------------------------------------------------------------------------
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Commons
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'jacquesbh/vim-showmarks'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tyru/restart.vim'
NeoBundle 'ack.vim'
NeoBundle 'vim-scripts/restore_view.vim'
NeoBundle 'vim-scripts/DirDiff.vim'
NeoBundle 'vim-scripts/VST'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-surround'
" Git
NeoBundle 'tpope/vim-fugitive'
" Python用
NeoBundle 'lambdalisue/vim-django-support'
NeoBundle 'python_fold'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'voithos/vim-python-matchit'
" Ruby/Rails用
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'


syntax on
filetype plugin indent on
"
 " Brief help
 " :NeoBundleList          - list configured bundles
 " :NeoBundleInstall(!)    - install(update) bundles
 " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
   "finish
 endif
"----------------------------------------------------------------------------

" MacVimでのDLL設定
let $PYTHON_DLL = "/opt/local/lib/libpython2.7.dylib"
let $RUBY_DLL = "~/.rbenv/versions/1.9.3-p286/lib/libruby.dylib"

" ファイルエンコーディングの自動検出
if has("kaoriya")
  set fileencodings=guess
endif

"----------------------------------------------------------------------------
" neocomplcache
"----------------------------------------------------------------------------
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"----------------------------------------------------------------------------

"----------------------------------------------------------------------------
" neosnippet
"----------------------------------------------------------------------------
" snippets directory
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
"----------------------------------------------------------------------------

"----------------------------------------------------------------------------
" unite.vim
"----------------------------------------------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" grep
noremap <C-U><C-G> :Unite grep<CR>
" unite grep settings For ack.
if executable('ack-5.12')
  let g:unite_source_grep_command = 'ack-5.12'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif
" 全部
"noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
noremap <C-U><C-H> :Unite help<CR>
noremap <C-U><C-M> :Unite mark<CR>
noremap <C-U><C-D> :Unite directory_mru<CR>
noremap <C-U>u :UniteResume<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"----------------------------------------------------------------------------

"----------------------------------------------------------------------------
" vimfiler
"----------------------------------------------------------------------------
" vimfilerをデフォルトにする
let g:vimfiler_as_default_explorer = 1
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
"----------------------------------------------------------------------------

"----------------------------------------------------------------------------
" showmarks
"----------------------------------------------------------------------------
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"help、quickfixと編集不可のバッファについて、マークを表示しない。-
let showmarks_ignore_type = "hqm"

" showmarks keyconfig
map <Leader>mt :DoShowMarks<CR>
map <Leader>mn :NoShowMarks<CR>
nnoremap ` :ShowMarksOnce<CR>
"----------------------------------------------------------------------------

" vimshell
let g:vimshell_prompt='% '
let g:vimshell_user_prompt = 'getcwd()'
nnoremap  :VimShellPop .<CR>

" misc
set textwidth=78

set nobackup
set hidden
set list
" 記号の幅を直す
set ambiwidth=double
set showcmd
set diffopt=filler,horizontal
" OSのクリップボードと共有
set clipboard=unnamed,autoselect
runtime macros/matchit.vim
colorscheme desert

" バッファを開いた時、バッファローカルのcdを変更する
" autocmd BufEnter * silent! lcd %:p:h
" バッファローカルのcdを変更
nnoremap <silent><Leader>c :lcd %:p:h<CR>

" quickrunのショートカットとかぶるので変更しておく
let g:jedi#rename_command = "<leader>R"
"  モジュールを補完する際にモジュール名単位で候補を表示
let g:ref_pydoc_complete_head = 1
" indent幅表示を起動時に有効化する
let g:indent_guides_enable_on_vim_startup = 1
" PowerLineにvirtualenvの表示を追加
call Pl#Theme#InsertSegment('virtualenv', 'after', 'filetype')

" quickrun config
if !exists("g:quickrun_config")
  let g:quickrun_config = {}
endif
let g:quickrun_config['rst'] = {
    \ 'command': 'rst2html-2.7.py',
    \ 'outputter': 'browser',
    \ }

" restore_view recommended settings
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
