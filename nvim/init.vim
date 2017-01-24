"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:uname = system("uname")
if s:uname == "Darwin\n"
    set runtimepath+=/Users/ox/.random/repos/github.com/Shougo/dein.vim
    call dein#begin('/Users/ox/.random')
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    set runtimepath+=/home/ox/.random/repos/github.com/Shougo/dein.vim
    call dein#begin('/home/ox/.random')
    let g:python3_host_prog = '/usr/bin/python3'
endif

"Macro Marvim configs should be set before sourcing the plugin
let marvim_store = '/dotfiles/nvim/macros'
" let marvim_find_key = '<Space>' 
" let marvim_store_key = 'ms' 
" let marvim_register = 'c' 

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

"------------------------------------------
" Add or remove your plugins here:
"------------------------------------------
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')
" call dein#add('zchee/deoplete-jedi')
call dein#add('junegunn/fzf', { 'build': './install', 'merged': 0 })
call dein#add('junegunn/fzf.vim')

" Tpope in my vimrc
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-surround')
" Pretty theme
call dein#add('junegunn/seoul256.vim')
" Writing
" call dein#add('reedes/vim-pencil')
call dein#add('junegunn/limelight.vim')
call dein#add('junegunn/goyo.vim')
" Pasting
call dein#add('ConradIrwin/vim-bracketed-paste')
" Git
call dein#add('airblade/vim-gitgutter')
" Macros
call dein#add('vim-scripts/marvim')

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
let g:deoplete#enable_at_startup=1
autocmd FileType markdown let g:deoplete#enable_at_startup=0
set updatetime=250 "for vim gitgutter

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

set showcmd

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

" show tabs, and trailing spaces
set listchars=tab:>~,nbsp:_,trail:.
set list

" easy command mode
nnoremap ; :

" Vim for writing - Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd Filetype markdown call SetMarkdownOptions()
function SetMarkdownOptions()
    " Auto hard wrap text
    set textwidth=64
    " Godsend par formatter
    set formatprg=par\ -w62
    set formatoptions+=t
    " Enable spellcheck.
    " set spell spelllang=en_us
    highlight CursorLine ctermbg=NONE
    let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
    " Lastly, invoke Goyo plugin.
    if !exists('#goyo')
        Goyo
    endif
endfunction
" " Configure vim pencil
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd call pencil#init()
"   autocmd FileType text         call pencil#init()
" augroup END
" Limelight on/off based on Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


" Support for tabs in Makefile
autocmd FileType make setlocal noexpandtab

" Better defaults
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Integrating 'fzy'
function! FzyCommand(choice_command, vim_command)
    try
        let output = system(a:choice_command . " | fzy ")
    catch /Vim:Interrupt/
        " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
        exec a:vim_command . ' ' . output
    endif
endfunction

" nnoremap <leader>e :call FzyCommand("ag . -l -g ''", ":e")<cr>
" nnoremap <leader>v :call FzyCommand("ag . -l -g ''", ":vs")<cr>
" nnoremap <leader>s :call FzyCommand("ag . -l -g ''", ":sp")<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

