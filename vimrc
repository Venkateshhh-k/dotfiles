"----------------------------------------------------------------------------------------------------------
"Plugins
"----------------------------------------------------------------------------------------------------------

call plug#begin ('~/.vim/plugged')


"-------------------------------------------- "NerdTree
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'scrooloose/nerdtree'
"-------------------------------------------- "Git (Vim-Fugitive)
Plug 'tpope/vim-fugitive'
"-------------------------------------------- "Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"-------------------------------------------- "Rainbow parenthesis
Plug 'frazrepo/vim-rainbow'
"-------------------------------------------- "Confortable motion
Plug 'yuttie/comfortable-motion.vim'
"-------------------------------------------- "ALE
"Plug 'dense-analysis/ale'
"-------------------------------------------- "Air Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"-------------------------------------------- "Purescript
Plug 'purescript-contrib/purescript-vim'
Plug 'frigoeu/psc-ide-vim'
"-------------------------------------------- "Fuzzy File Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"-------------------------------------------- "Vim Gitgutter
Plug 'airblade/vim-gitgutter'
"-------------------------------------------- "Auto Pairs
Plug 'jiangmiao/auto-pairs'
"-------------------------------------------- "NNN-fast and featurefull file manager
"Plug 'mcchrish/nnn.vim'
"-------------------------------------------- "PureScript langauge client
Plug 'sriharshachilakapati/vimmer-ps'
"-------------------------------------------- "Indent line
Plug 'Yggdroot/indentLine'
"-------------------------------------------- " Interactive ScratchPad
Plug 'metakirby5/codi.vim'
"-------------------------------------------- " COC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"-------------------------------------------- " Hoogle search Haskell) in Vim
Plug 'Twinside/vim-hoogle'
"-------------------------------------------- " ghcid for Haskell
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-haskellimport'

"Haskell plugins
"Plug 'twinside/vim-haskellconceal'
"Plug 'twinside/vim-haskellfold'
"Plug 'enomsg/vim-haskellconcealplus'
"Plug 'alx741/vim-hindent'
"Plug 'jagua/vim-denite-ghq'

call plug#end()



"----------------------------------------------------------------------------------------------------------
"Core Functionality (general settings, keyboard shortcuts)
"----------------------------------------------------------------------------------------------------------

set mouse=a
:let mapleader = "'"
syntax on                       "Turn on syntax highlighting

set noswapfile
set nobackup                    "Turn Off backup files
set nowb

set scrolloff=5
set cmdheight=5
set autoread                    "Reload files changed outside vim
set visualbell                  "No sounds
set showcmd                     "Show incomplete cmds down the bottom
set history=1000                "Store lots of :cmdline history
set backspace=indent,eol,start  "Allow backspace in insert mode
set hlsearch
set tabstop=4
set shiftwidth=4
set autoindent
set copyindent
set number
set expandtab
set showmatch
set ignorecase
set smartcase
set smarttab
set incsearch
set relativenumber
set autoread
set ic
"set showmode
set shell=zsh
set so=7                       "Set 7 lines to the cursor when moving vertically using JK
set wrap
set ttyfast                    "Rendering
"save with ZZ
nnoremap zz :update<cr>        
" set clipboard to easily copy from vim and paste into OSx
set clipboard=unnamed

"-------------------------------" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"----------------------------------------------" Fuzzy File Finder Configuration
"Use Control P to open FZF
nnoremap <C-P> :Files<CR>
"Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
nnoremap <C-P> :Files<CR>
nnoremap <C-P> :Files<CR>
nnoremap <C-P> :Files<CR>

"---------------------------------------------- Find syntax group
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
"----------------------------------------------
set nowrap
filetype on
filetype plugin indent on
filetype plugin on
"-----------------------------------------------" Easier buffer navigation
nnoremap <S-J> :bp<CR>         
nnoremap <S-K> :bn<CR>
"-----------------------------------------------" Use Control+B to toggle gitbalme
nnoremap <C-B> :Gblame<CR>
"-----------------------------------------------" Use JJ insted of ESC
inoremap jj <ESC>
"-----------------------------------------------" Split windows
set splitbelow
set splitright
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"----------------------------------------------- Persistent Undo -----------------------------------
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


"----------------------------------------------- Nerdtree Configuration -----------------------------------
autocmd StdinReadPre * let s:std_in=1            "Open Nerd Tree automatically if no file was specified while opening
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"----------------------------------------------- "Nerdtree toggle
map <Space>f :NERDTreeToggle<CR>
"----------------------------------------------- "Nerdtree Find  Use / search, gg and G liberally to move around faster
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
"-----------------------------------------------
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"-----------------------------------------------
" NERDTree File highlighting
"-----------------------------------------------
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('purs', 'Red', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('hs', 'yellow', 'none', 'cyan', '#151515')


let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


"----------------------------------------------- Git[Vim-Fugitive] -----------------------------------
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

"----------------------------------------------------------------------------------------------------------
"ALE
"----------------------------------------------------------------------------------------------------------
"-----------------------------------------------
"Showing warinings configuration
"-----------------------------------------------
"let g:ale_sign_error = '●'
"highlight ALEErrorSign guifg=#f2777a
"highlight SpellBad guisp=#f2777a
"let g:ale_sign_warning = '◇'
"highlight ALEWarningSign guifg=#ffcc66
"highlight SpellCap guisp=#ffcc66

"function! LinterStatus() abort
 "   let l:counts = ale#statusline#Count(winbufnr('$'))

"    if l:counts.total == 0
 "       return '✓'
  "  endif

   " let l:errors = l:counts.error + l:counts.style_error
    "let l:warnings = l:counts.total - l:errors

   " if l:errors > 0 && l:warnings > 0
    "    return '◇ ●'
   " endif

"    if l:errors > 0
"        return '●'
 "   endif

  "  if l:warnings > 0
 "       return '◇'
 "   endif
"endfunction

"-----------------------------------------------" Show 5 lines of errors
let g:ale_list_window_size = 5
"-----------------------------------------------
"Navigate between errors quickly
"-----------------------------------------------
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
"-----------------------------------------------
"Deoplete configuration
"-----------------------------------------------
"let g:deoplete#enable_at_startup = 1
"-----------------------------------------------

"----------------------------------------------------------------------------------------------------------
"Rainbow parenthesis configuration
"----------------------------------------------------------------------------------------------------------
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"----------------------------------------------------------------------------------------------------------
"Remappings
"----------------------------------------------------------------------------------------------------------
"----------------------------------------------" Remap :W when i mean to :w
command! W w
"----------------------------------------------" Unsets the 'last search pattern' register buy hitting return
 nnoremap <CR> :noh<CR><CR>
"----------------------------------------------" search selected text in visual mode
vnoremap // y/\V<C-R>"<CR>
"----------------------------------------------" Debugging syntax highlighting
map gsy :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"----------------------------------------------" ConfortableMotionConfigurtion

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"


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


"----------------------------------------------" Air Line Configuration
let g:airline_powerline_fonts = 1
"----------------------------------------------" Purescript Configuration
let purescript_indent_if = 3
let purescript_indent_case = 5
let purescript_indent_let = 4
let purescript_indent_where = 6
let purescript_indent_do = 3
let purescript_indent_in = 1
let purescript_indent_dot = v:true
let g:psc_ide_log_level = 3


nm <buffer> <silent> <leader>L :Plist<CR>
nm <buffer> <silent> <leader>l :Pload!<CR>
nm <buffer> <silent> <leader>r :Prebuild!<CR>
nm <buffer> <silent> <leader>f :PaddClause<CR>
nm <buffer> <silent> <leader>t :PaddType<CR>
nm <buffer> <silent> <leader>a :Papply<CR>
nm <buffer> <silent> <leader>A :Papply!<CR>
nm <buffer> <silent> <leader>C :Pcase!<CR>
nm <buffer> <silent> <leader>i :Pimport<CR>
nm <buffer> <silent> <leader>qa :PaddImportQualifications<CR>
nm <buffer> <silent> <leader>g :Pgoto<CR>
nm <buffer> <silent> <leader>p :Pursuit<CR>
nm <buffer> <silent> <leader>T :Ptype<CR>

"----------------------------------------------"Gitgutter Configuration
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

let g:gitgutter_sign_added = '＋'
let g:gitgutter_sign_modified = '✎'
let g:gitgutter_sign_removed = '⋙'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'

highlight link GitGutterChangeLine DiffText
"let g:gitgutter_diff_relative_to = 'working_tree'
"let g:gitgutter_diff_base = '<commit SHA>'
"let g:gitgutter_git_args = '--git-dir-""'
"let g:gitgutter_highlight_lines = 1
"let g:gitgutter_highlight_linenrs = 1

"highlight link diffAdded DiffAdd
"highlight link diffChanged DiffChange
"highlight link diffRemoved DiffDelete

"----------------------------------------------"NNN Configuration
" Disable default mappings
"let g:nnn#set_default_mappings = 0

"Set own Configuration
"nnoremap <silent> <leader>sd :NnnPicker<CR>

" Start nnn in the current file's directory
"nnoremap <leader>n :Picker '%:p:h'<CR>

"--------------- Layout
" Opens the nnn window in a split
"let g:nnn#layout = 'new' " or vnew, tabnew etc.

" Or pass a dictionary with window size
"let g:nnn#layout = { 'left': '~20%' } " or right, up, down

" Floating window (neovim latest and vim with patch 8.2.191)
"let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

"--------------- "Purescript language client Configuration
"let g:vimmerps_disable_mappings = v:true



"--------------- "Indent Line
"glet g:indentLine_color_term = 239

"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

set list
set listchars=
set listchars+=tab:░\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

"=====> COC Configuration <=====
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"=====> Haskell Plugins <=====
nnoremap <silent> ;h :execute "Unite -start-insert haskellimport"<CR>
