syntax on

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set noshowmode
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set backspace=indent,eol,start
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.pdf,*.o,*.obj,*.jpg,*.png,*.pyc,*.py.log
set path=**
set updatetime=50
set shortmess+=c
set ignorecase
set cursorline
set rtp+=/usr/local/opt/fzf
set timeoutlen=1000 ttimeoutlen=0
set spell spelllang=en
set exrc
set secure

set background=dark
set t_Co=256

let g:coc_global_extensions = ['coc-pyright']

let mapleader = " "

" Fat finger helpers
command Q :quit
command W :w
command Wq :wq
command WQ :wq
map q: <Nop>

command! -nargs=1 NewZettel :execute ":e" "~/notes/" . strftime("%Y%m%d%H%M") . "-<args>.md"
nnoremap <leader>nn :NewZettel 

" Helpers
nnoremap <C-e> :E<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Font 
" Install https://www.jetbrains.com/lp/mono/
" Char spacing 1.046
" Line space 1.1

call plug#begin('~/.vim/plugged')

" UI
Plug 'gruvbox-community/gruvbox' " Best colour scheme
Plug 'vim-airline/vim-airline' " Status bar

" File types
Plug 'lepture/vim-jinja'
Plug 'ekalinin/Dockerfile.vim'

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'

Plug 'tpope/vim-surround'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install fzf && brew install ripgrep

Plug 'neoclide/coc.nvim', {'branch': 'release'} " code complete :CocInstall coc-pyright
Plug 'vim-test/vim-test' " Testing
" Git
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-rhubarb' " Git browse
Plug 'airblade/vim-gitgutter' " Git gutter

Plug 'tpope/vim-commentary'

call plug#end()

colorscheme gruvbox " Best color scheme, no doubt, unbeatable 

augroup WrapFileTypes
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType vimwiki set wrap
  autocmd FileType qf setlocal wrap
augroup END

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.j2 set ft=jinja

" Test running
let test#strategy = "vimterminal"
let test#python#pytest#options = "--disable-pytest-warnings -q"

nnoremap <leader>; :w<bar>:TestNearest<cr>
nnoremap <leader>' :w<bar>:TestFile<cr>
nnoremap <leader>` :wa<bar>:TestSuite<cr>

" Copying to clipboard
set clipboard=unnamed

" Terminal
set termwinsize=20x0

nnoremap <leader>t :bot term ++close<CR>

" Git
let g:github_enterprise_urls = ['https://github.je-labs.com']

nnoremap <leader>gg :Git<CR>
nnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gp :G push<CR>
nnoremap <leader>gn :G checkout master<bar>:G pull<bar>:G checkout -b 
nnoremap <leader>gm :G checkout master<bar>:G pull<CR>

" fzf remaps
nnoremap <leader>o :Files<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>/ :Rg<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob=\!.git'

nmap <leader>l  <Plug>(coc-format)

" 
" " --- Coc Config ---
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
