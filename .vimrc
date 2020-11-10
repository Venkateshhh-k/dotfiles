"=====> Plugins <=====
call plug#begin ('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}                                     "COC
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }                                                                             "LanguageClient
Plug 'mcchrish/nnn.vim'                                                             "NNN
Plug 'neovimhaskell/haskell-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'dense-analysis/ale'                                                           "ALE
Plug 'preservim/nerdtree'                                                           "NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'                                                      "AirLine
Plug 'vim-airline/vim-airline-themes'
Plug 'epmatsw/ag.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sriharshachilakapati/vimmer-ps'



call plug#end()

"=====> LanguageClient <=====
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'haskell': ['ghcide', '--lsp', 'hie-wrapper']
    \ }
nnoremap K :call LanguageClient#textDocument_hover()
nnoremap gd :call LanguageClient#textDocument_definition()
nnoremap :call LanguageClient#textDocument_rename()
nnoremap :call LanguageClient_contextMenu()


"=====> COC <=====
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
	set signcolumn=number
else
	set signcolumn=yes
endif

"======> Use tab for trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"=====> Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"=====> Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"=====> NNN <=====

"nnoremap <leader>n :NnnPicker '%:p:h'<CR>
"let $NNN_TRASH=1
" Opens the nnn window in a split
let g:nnn#layout = 'new' " or new,vnew, tabnew etc.

" Or pass a dictionary with window size
let g:nnn#layout = { 'left': '~20%' } " or right, up, down

" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }


"=====> Haskell <=====
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1

let g:hdevtools_stack = 1
"=====> Mappings <=====

"=====> General
let g:mapleader = " "   " Set leader to spacebar
inoremap jj <ESC>:w<CR>
map <C-n> :noh<cr>
syntax on
filetype plugin indent on
filetype plugin on
"set background=light
set termguicolors
let ayucolor="dark"              "light, dark, mirage
colorscheme ayu
set mouse=a
set cmdheight=2
set winminheight=0               " Allow windows to get fully squashed
set ttyfast
set visualbell
set noerrorbells
set showcmd
set history=1000
set backspace=indent,eol,start   "Allow backspace in insert mode
set tabstop=2
set number
set autoread
set shell=zsh
set so=10                         "Set 7 lines to the cursor when moving vertically using JK
nnoremap zz :update<cr>
set clipboard=unnamed
set splitbelow
set splitright
set hidden
set nowrap
command! W w                     "Remap :W when i mean to :w
vnoremap // y/\V<C-R>"<CR>

"===> Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

"===> Unsets the 'last search pattern' register buy hitting return
nnoremap <CR> :noh<CR><CR>
"===> Show 5 lines of errors
let g:ale_list_window_size = 5
"===> 
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


"=====> Splits
map <C-x> :split<CR>
map <C-v> :vsplit<CR>
nnoremap gh <C-W><C-H>
nnoremap gj <C-W><C-J>
nnoremap gk <C-W><C-K>
nnoremap gl <C-W><C-L>
nnoremap <Up> :resize +2<CR> 
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

"=====> ALE <=====
nmap <silent> <C-e> <Plug>(ale_next_wrap)

"===> Show number of errors and warnings in status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

"=====> NerdTree <=====
map <C-n> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'

"=====> WhiteSpace <=====
"--------------- "Indent Line
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

set list
set listchars=
set listchars+=tab:░\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

"=====> Confortable Motion <=====

let g:comfortable_motion_scroll_down_key = "o"
let g:comfortable_motion_scroll_up_key = "p"

noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

let g:comfortable_motion_friction = 200.0
let g:comfortable_motion_air_drag = 2.0

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

"=====> AirLine Configuration <=====
let g:airline_powerline_fonts = 1

"=====> Ag <=====
let g:agprg="<custom-ag-path-goes-here> --column"

"====> Use Ctrl-P to open FZF <=====
nnoremap <C-P> :FZF<CR>

" Echodoc configuration for LanguageClient
set noshowmode
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

" Default Language Server configuration
let g:LanguageClient_autoStart=1
let g:LanguageClient_autoStop=1
let g:LanguageClient_serverCommands={}
let g:LanguageClient_windowLogMessageLevel="Log"
let g:LanguageClient_loggingLevel="INFO"
let g:LanguageClient_trace="verbose"
let g:LanguageClient_useVirtualText=1

" Purescript specific configuration
if has('autocmd')
    autocmd filetype purescript setlocal tabstop=2
    autocmd filetype purescript setlocal shiftwidth=2
    autocmd filetype purescript setlocal colorcolumn=81

    " Unplace the existing signs before saving
    autocmd BufWritePre *.purs :sign unplace *

    autocmd filetype purescript let &l:commentstring='--%s'
    autocmd filetype purescript let g:NERDCommentEmptyLines=1
    autocmd filetype purescript let g:NERDDefaultAlign='left'
    autocmd filetype purescript let g:NERDSpaceDelims=1
endif


" Easier buffer navigation
nnoremap <S-J> :bp<CR>
nnoremap <S-K> :bn<CR>

" Use Ctrl-B to toggle Git Blame
nnoremap <C-B> :Gblame<CR>

