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

call plug#begin('~/.vim/plugged')

" UI
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'

" File types
Plug 'lepture/vim-jinja'
Plug 'ekalinin/Dockerfile.vim'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" brew install fzf && brew install ripgrep

" Code complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
":CocInstall coc-pyright

" Testing
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tartansandal/vim-compiler-pytest'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Notes
Plug 'vimwiki/vimwiki'

call plug#end()

set background=dark
set t_Co=256

" Best color scheme, no doubt, unbeatable 
colorscheme gruvbox

let mapleader = " "

" Fat finger helpers
command Q :quit
command W :w
command Wq :wq
command WQ :wq
map q: <Nop>

nnoremap <C-e> :E<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

let g:vimwiki_map_prefix = '<leader>v'

augroup WrapFileTypes
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType vimwiki set wrap
  autocmd FileType qf setlocal wrap
augroup END

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.j2 set ft=jinja

" Test running
"let test#strategy = "vimterminal"
let test#strategy = "dispatch"
let test#python#pytest#options = "--disable-pytest-warnings --tb=short -q"

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
