set nocompatible
"----------------------------------------------------------------------------
" neobundle
"----------------------------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Commons
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
if has('lua') && (v:version >= 704 || (v:version >= 703 && has('patch885')))
  NeoBundleLazy "Shougo/neocomplete.vim", { 'autoload' : {
        \ 'insert' : 1,
        \ }}
  let s:hooks = neobundle#get_hooks("neocomplete.vim")
  function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0

    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
          \ 'default' : '',
          \ 'vimshell' : $HOME.'/.vimshell_hist',
          \ 'scheme' : $HOME.'/.gosh_completions',
          \ 'php' : $HOME.'/.php_completions'
          \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#smart_close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() . " " : "\<Space>"

    " Enable omni completion.
    augroup vimrc_neocomplete
      autocmd!
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php =
    "                  \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  endfunction
endif
" NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neosnippet'
      "\ 'autoload' : {
      "\   'commands' : ['NeoSnippetEdit', 'NeoSnippetSource'],
      "\   'filetypes' : 'snippet',
      "\   'insert' : 1,
      "\   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
      "\ }}
"let s:hooks = neobundle#get_hooks("neosnippet.vim")
"function! s:hooks.on_source(bundle)
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
"endfunction
NeoBundleLazy "Shougo/unite.vim", {
      \ "autoload": {
      \   "commands": ["Unite", "UniteWithBufferDir"]
      \ }}
NeoBundleLazy 'h1mesuke/unite-outline', {
      \ "autoload": {
      \   "unite_sources": ["outline"],
      \ }}

NeoBundleLazy 'tacroe/unite-mark', {
      \ "autoload": {
      \   "unite_sources": ["mark"],
      \ }}
NeoBundleLazy 'tsukkee/unite-tag', {
      \ "autoload": {
      \   "unite_sources": ["tag"],
      \ }}
NeoBundleLazy 'tsukkee/unite-help', {
      \ "autoload": {
      \   "unite_sources": ["help"],
      \ }}
NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \ "autoload": {
      \   "unite_sources": ["quickfix"],
      \ }}

NeoBundleLazy 'thinca/vim-quickrun', {
      \ "autoload": {
      \ "commands": ["QuickRun"],
      \ }}
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  " quickrun config
  if !exists("g:quickrun_config")
    let g:quickrun_config = {}
  endif
  let g:quickrun_config['rst'] = {
        \ 'command': 'rst2html-2.7.py',
        \ 'outputter': 'browser',
        \ }
endfunction

NeoBundleLazy 'thinca/vim-ref', {
      \ "autoload": {
      \ "commands": ["Ref"],
      \ "unite_sources": ["ref"],
      \ }}
let s:hooks = neobundle#get_hooks("vim-ref")
function! s:hooks.on_source(bundle)
  let g:ref_phpmanual_path='/Users/aqn/Documents/php-chunked-xhtml'
  "  モジュールを補完する際にモジュール名単位で候補を表示
let g:ref_pydoc_complete_head = 1
endfunction

NeoBundleLazy 'mattn/zencoding-vim', {
      \ 'autoload' : {
      \ 'filetypes': ['html']
      \}}
if has('gui_running')
  NeoBundle 'altercation/vim-colors-solarized'
else
  colorscheme desert
endif
if has('mac') && has('kaoriya')
  " NeoBundle 'alpaca-tc/alpaca_powertabline'
  " let g:alpaca_powertabline_enable=1
  NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
endif
NeoBundleLazy 'chrisbra/SudoEdit.vim', {
      \ 'autoload' : {
      \   "commands": ["SudoWrite", "SudoRead"],
      \ }}
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'tyru/restart.vim', {
      \ 'autoload' : {
      \   "commands": ["Restart"],
      \ }}
"NeoBundle 'ack.vim'
"NeoBundle 'vim-scripts/restore_view.vim'
"NeoBundle 'vim-scripts/DirDiff.vim'
"NeoBundle 'vim-scripts/VST'
NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload' : {
      \   "commands": ["OpenBrowser", "OpenBrowserSearch", "OpenBrowserSmartSearch"],
      \ }}

NeoBundle 'tpope/vim-surround'
NeoBundleLazy 'othree/html5.vim', {
      \ 'autoload' : {
      \ 'filetypes': ['html']
      \}}
NeoBundleLazy 'HTML5-Syntax-File', {
      \ 'autoload' : {
      \ 'filetypes': ['html']
      \ }}
" Git
NeoBundle 'tpope/vim-fugitive'
" Python用
" NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundleLazy 'lambdalisue/vim-django-support', {
    \ 'autoload' : {
    \ 'filetypes': ['python']
    \ }}
NeoBundleLazy 'python_fold', {
    \ 'autoload' : {
    \ 'filetypes': ['python']
    \ }}
"NeoBundle 'davidhalter/jedi-vim'
NeoBundleLazy 'voithos/vim-python-matchit', {
    \ 'autoload' : {
    \ 'filetypes': ['python']
    \ }}
" Ruby/Rails用
NeoBundleLazy 'vim-ruby/vim-ruby', {
    \ 'autoload': {
    \ 'filetypes': ['ruby', 'eruby', 'haml'],
    \ }}
NeoBundleLazy 'mattn/benchvimrc-vim', {
    \ 'autoload': {
    \ 'commands': ['BenchVimrc'],
    \ }}
NeoBundleLazy 'scrooloose/syntastic', {
    \ 'autoload' : {
    \ 'filetypes' : ['php'],
    \ }}
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'shawncplus/phpcomplete.vim', {
    \ 'autoload' : {
    \ 'filetypes' : ['php'],
    \ }}


syntax on
filetype plugin indent on
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

NeoBundleCheck
"----------------------------------------------------------------------------
" release autogroup in vimrc_cmd
augroup vimrc_cmd
  autocmd!
augroup END

" MacVimでのDLL設定
"let $PYTHON_DLL = "/opt/local/lib/libpython2.7.dylib"
"let $RUBY_DLL = "~/.rbenv/versions/2.0.0-p0/lib/libruby.dylib"
let $LUA_DLL = "/usr/local/Cellar/lua52/5.2.1/lib/liblua.dylib"

" ファイルエンコーディングの自動検出
if has("kaoriya")
  set fileencodings=guess
endif

"----------------------------------------------------------------------------
" neosnippet
"----------------------------------------------------------------------------

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
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
" 全部
"noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
noremap <C-U><C-H> :Unite help<CR>
noremap <C-U><C-M> :Unite mark<CR>
noremap <C-U><C-D> :Unite directory_mru<CR>
noremap <C-U><C-Q> :Unite quickfix<CR>
noremap <C-U>u :UniteResume<CR>
nnoremap <silent><C-U><C-O> :Unite -no-quit -vertical -winwidth=30 outline<CR>
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
" let showmarks_enable = 1
" Show which marks
" let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"help、quickfixと編集不可のバッファについて、マークを表示しない。-
" let showmarks_ignore_type = "hqm"

" showmarks keyconfig
" map <Leader>mt :DoShowMarks<CR>
" map <Leader>mn :NoShowMarks<CR>
" nnoremap ` :ShowMarksOnce<CR>
"----------------------------------------------------------------------------

" vimshell
let g:vimshell_prompt='% '
let g:vimshell_user_prompt = 'getcwd()'
nnoremap  :VimShellPop .<CR>


" バッファを開いた時、バッファローカルのcdを変更する
" autocmd BufEnter * silent! lcd %:p:h
" バッファローカルのcdを変更
nnoremap <silent><Leader>c :lcd %:p:h<CR>

" quickrunのショートカットとかぶるので変更しておく
let g:jedi#rename_command = "<leader>R"
" indent幅表示を起動時に有効化する
let g:indent_guides_enable_on_vim_startup = 1
" PowerLineにvirtualenvの表示を追加
" call Pl#Theme#InsertSegment('virtualenv', 'after', 'filetype')


" restore_view recommended settings
" set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>

" zencoding-vim
let g:user_zen_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : ' '
      \  }
      \}

" If you want to complete tags using |omnifunc| then add this.

let g:use_zen_complete_tag = 1

" common keymaps
nmap k gk
nmap j gj
nmap <UP> gk
nmap <DOWN> gj

""" Persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000  " number of changes that can be undone
set undoreload=10000 " number lines to save for undo on a buffer reload

let g:syntastic_php_checkers=['php', 'phpmd', 'phpcs']

" misc
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hidden
" 記号の幅を直す
set ambiwidth=double
set showcmd
set diffopt=filler,horizontal
" OSのクリップボードと共有
set clipboard=unnamed,autoselect
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
set nowritebackup
set nobackup
set noswapfile
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:$
set noshowmode

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

runtime macros/matchit.vim

" make, grep などのコマンド後に自動的にQuickFixを開く
" autocmd vimrc_cmd QuickfixCmdPost * copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd vimrc_cmd FileType help,qf nnoremap <buffer> q <C-w>c

let g:sudoAuth=" sudo su "
