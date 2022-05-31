set relativenumber
set number
set cursorline
set background=dark
set ignorecase
set spell spelllang=en
set signcolumn=yes
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set exrc
set noerrorbells
set clipboard=unnamed

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible' " Good default for vim
Plug 'gruvbox-community/gruvbox' " Best colour scheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Search
Plug 'junegunn/fzf.vim' " brew install fzf && brew install ripgrep
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code complete
Plug 'vim-test/vim-test' " Testing
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-rhubarb' " Git browse
Plug 'airblade/vim-gitgutter' " Git gutter
Plug 'tpope/vim-commentary' " Commenting
Plug 'lervag/vimtex' " LeTex integration
call plug#end()

" Desktop background - https://imgur.com/a/oD7R8W2
" Typeface https://www.jetbrains.com/lp/mono/ char spacing 1.046 line space 1.1
colorscheme gruvbox " Best color scheme, no doubt, unbeatable 
let mapleader = " "

" Helpers
nnoremap <C-e> :E<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

autocmd FileType markdown set wrap
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

" Fat finger helpers
command Q :quit
command W :w
command Wq :wq
command WQ :wq
map Q <Nop>

" Note taking
command! -nargs=1 NewZettel :execute ":e" "~/notes/" . strftime("%Y%m%d%H%M") . "-<args>.md"
nnoremap <leader>nn :NewZettel 

" Testing
let test#strategy = "vimterminal"
let test#python#pytest#options = "--disable-pytest-warnings -q"

nnoremap <leader>; :w<bar>:TestNearest<cr>
nnoremap <leader>' :w<bar>:TestFile<cr>
nnoremap <leader>` :wa<bar>:TestSuite<cr>

" Git
let g:github_enterprise_urls = ['https://github.je-labs.com']

nnoremap <leader>gg :Git<CR>
nnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gp :G push<CR>

" fzf remaps
nnoremap <leader>o :Files<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>/ :Rg<CR>

set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob=\!.git'

source ~/dot-files/coc.vim
