call plug#begin()
"ここにプラグインを書く
Plug 'mattn/emmet-vim'	"html補完のインストール
Plug 'lervag/vimtex' 	"LaTeX拡張vimtexのインストール
Plug 'kannokanno/previm' "MarkDownのプレビュー
Plug 'plasticboy/vim-markdown' "MarkDownの補完とハイライト
Plug 'tyru/open-browser.vim' "vimでブラウザを開く
Plug 'Shougo/deoplete.nvim' "補完機能
Plug 'Shougo/neocomplcache.vim' "補完機能
Plug 'Shougo/neosnippet.vim' "スニペット補完機能
Plug 'artur-shaik/vim-javacomplete2' "omni補完 <C-x><C-o>
Plug 'eclipse/eclipse.jdt.ls' "javaのIDE風にする
Plug 'w0rp/ale' "非同期のシンタックスチェック
Plug 'thinca/vim-quickrun' "/rと打つとコンパイルしてくれる
Plug 'tpope/vim-surround' "括弧とかクォーテーションのサポート
call plug#end()

set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

set nu		"行数を表示"
set relativenumber	"現在の行数を表示
set incsearch 	"1文字入力毎に検索を行う"
set ignorecase	"検索時に大文字小文字を区別しない"
set smartcase	"検索パターンに大文字を含んでいたら大文字小文字を区別する"
set hlsearch	"検索結果をハイライト"

"F3を押すたびに検索ハイライトの切り替え"
nnoremap <F3> :set hlsearch!<cr>

set tabstop =4			"タブ文字が占める幅"
set autoindent			"改行時に前の行のインデントを継続する"
set smartindent			"改行時に前の行の構文をチェックし、次の行のインデントを増減する"
set shiftwidth =4		"smartindentで増減する幅"
set cursorline 		"カーソルラインをハイライト"
set wildmenu		"コマンドモードの補完"
set history =100	"保存するコマンド履歴の数"

set nocompatible	"vi互換モードを廃止
set clipboard=unnamed,autoselect

"空白文字の表示
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    syntax on
 
    " PODバグ対策
    syn sync fromstart
 
    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endfunction
 
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

"ここまで
"

"VimTab関連
"" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"Tab関連終了
"



"Vimdiffのカラーセッティング
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

set backspace =indent,eol,start	"backspaceが効かなくなったので設定(vim version8以降)
set backspace =2	"backspaceが効かなくなったので設定(vim version8以降)

"zsh(端末)導入後にBackSpaceが聞かない問題を修正
"※  Vi互換モードでないと再発注意
noremap  
noremap!  

"emmetの設定
let g:user_emmet_leader_key = '<C-E>'	"emmetのキーバインドをCtrl+Eに変更

"vimtexの設定
let g:vimtex_view_general_viewer = 'evince' "vimtex<>lvで直接evinceを使用する。

"Previmの設定
let g:previm_open_cmd =''	"vivaldiでプレビューを開く
let g:previm_enable_realtime=1 "リアルタイムで反映する
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown "markdownとしてファイルを設定する


"Neosnippetの設定
let g:neosnippet#snippets_directory= '$HOME/.vim/snippets/'

"javacompleteの設定
autocmd FileType java setlocal omnifunc=javacomplete#Complete
