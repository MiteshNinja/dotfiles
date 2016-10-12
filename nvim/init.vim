let g:python3_host_prog = '/usr/local/bin/python3'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:uname = system("uname")
if s:uname == "Darwin\n"
    set runtimepath+=/Users/ox/.random/repos/github.com/Shougo/dein.vim
    call dein#begin('/Users/ox/.random')
else
    set runtimepath+=/home/ox/.random/repos/github.com/Shougo/dein.vim
    call dein#begin('/home/ox/.random')
endif

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

"------------------------------------------
" Add or remove your plugins here:
"------------------------------------------
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')

" Tpope in my vimrc
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-surround')
" Pretty theme
call dein#add('junegunn/seoul256.vim')

"------------------------------------------
" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Enable plugins
call deoplete#enable()
colo seoul256

set relativenumber number
autocmd CompleteDone * pclose

set tabstop=4  		" number of visual spaces interpreted for each tab
set softtabstop=4      	" number of spaces inserted when using tab
set expandtab  		" expand tabs to spaces
set shiftwidth=4        " When indenting with > / <
set smartindent

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

"searching
set ignorecase
set smartcase
set incsearch
set nohlsearch

"map ESC to something senible
imap qp <Esc>

" NeoSnippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
      \ "\<Plug>(neosnippet_jump_or_expand)" : "\<CR>"
smap <silent><CR> <Plug>(neosnippet_jump_or_expand)