" -----------------------------
"  Clean .vimrc (Vim, not Neovim)
"  - Plugin manager: vim-plug
"  - Fuzzy finding: fzf.vim (uses ripgrep if available)
"  - Lint/format: ALE (async)
"  - Snippets: UltiSnips + vim-snippets
"  - Git: fugitive + gitgutter
"  - UI: airline + onedark
" -----------------------------

" Basics
set nocompatible
set encoding=utf-8

" Faster startup; matchit is built-in in modern Vim
silent! packadd! matchit

" Bootstrap vim-plug if missing (requires curl)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload ~/.vim/plugged
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup PlugBootstrap
    autocmd!
    autocmd VimEnter * ++once PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" -----------------------------
" Plugins
" -----------------------------
call plug#begin('~/.vim/plugged')

" Theme & statusline
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation & search (ripgrep recommended)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Editing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'          " lightweight comment toggling
Plug 'jiangmiao/auto-pairs'          " modern autopairs

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Linting / Formatting / LSP bridge
Plug 'dense-analysis/ale'

" Project root detection (replaces BufEnter cd hack)
Plug 'airblade/vim-rooter'

" Virtualenv support
Plug 'jmcantrell/vim-virtualenv'

" Language extras (optional)
" Plug 'HerringtonDarkholme/yats.vim' " extra TS syntax for Vim (Treesitter is Neovim only)

call plug#end()

" Enable filetype detection, plugins and indentation
filetype plugin indent on
syntax on

" -----------------------------
" UI / Look & feel
" -----------------------------
set number
"set relativenumber "useful for offsets
set laststatus=2
set signcolumn=yes
set scrolloff=3

if has('termguicolors')
  set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme onedark
endif

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

" Highlight trailing whitespace (simple, no plugin)
" Define the group immediately on startup to prevent race conditions.
highlight default ExtraWhitespace ctermbg=Red guibg=#553333

augroup TrimWS
  autocmd!
  " Re-define it on theme change to prevent it from being overwritten.
  autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=Red guibg=#553333

  " Match trailing whitespace in different modes.
  autocmd BufWinEnter,WinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match none
augroup END

" -----------------------------
" Editing behavior
" -----------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Filetype-specific tabs
autocmd FileType html,htmldjango,css,javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

set smartindent
set autoindent

set textwidth=80
set nowrap
set list
set listchars=tab:»·,trail:·,extends:›,precedes:‹,nbsp:␣
set textwidth=0
set colorcolumn=+1

set formatoptions=qrn1

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Completion menu behavior (plays nicely with ALE completion)
set wildmode=list:longest
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/build/*,*/.venv/*,*/.mypy_cache/*,*/.pytest_cache/*,*/coverage/*
set completeopt=menu,menuone,noselect

" Clipboard (comment out if you don't want system clipboard by default)
if has('clipboard')
  set clipboard=unnamedplus
endif

" -----------------------------
" Project root & working dir
" -----------------------------
" vim-rooter will set cwd to project root intelligently (Git, etc.)
let g:rooter_patterns = ['.git', '.hg', '.svn', 'pyproject.toml', 'setup.cfg', 'Makefile', 'go.mod', 'package.json']

" -----------------------------
" FZF: fast files & grep
" -----------------------------
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ \!\.git
  set grepformat=%f:%l:%c:%m
endif

let mapleader = ","

nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>fr :call fzf#vim#resume('rg')<CR>
nnoremap <leader>fb :BLines<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>fm :Commits<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :Helptags<CR>

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>

function! s:toggle_quickfix() abort
  for win in range(1, winnr('$'))
    if getwinvar(win, '&buftype') ==# 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction

command! CopenToggle call s:toggle_quickfix()
nnoremap <leader>qo :CopenToggle<CR>

command! -nargs=0 RgResume call fzf#vim#resume('rg')

nnoremap <leader>tw :setlocal wrap!<CR>
nnoremap <leader>tl :setlocal list!<CR>
nnoremap <leader>ts :setlocal spell!<CR>
nnoremap <leader>tr :setlocal relativenumber!<CR>

" Tab navigation (non-recursive, less intrusive than bare `map`)
nnoremap <leader>t] :tabnext<CR>
nnoremap <leader>t[ :tabprevious<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" -----------------------------
" ALE: linters & formatters
" -----------------------------
" Enable ALE completion integration
let g:ale_completion_enabled = 1

" Fix on save for selected languages (install tools: black, ruff, prettier, gofmt, etc.)
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ 'python': ['black', 'ruff'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'json': ['prettier'],
\ 'css': ['prettier'],
\ 'go': ['gofmt'],
\ }

let g:ale_python_auto_pipenv = 1
let g:ale_python_auto_poetry = 1
let g:ale_use_global_executables = 0

" Choose linters / LSP backends
let g:ale_linters = {
\ 'python': ['ruff', 'mypy'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint', 'tsserver'],
\ 'go': ['gopls'],
\ }

" Handy mappings with ALE
nnoremap <silent> [d :ALEPrevious<CR>
nnoremap <silent> ]d :ALENext<CR>
nnoremap <silent> <leader>af :ALEFix<CR>
nnoremap <silent> K :ALEHover<CR>

" Virtualenv location (adjust to taste)
let g:virtualenv_directory = '~/Virtualenvs'

" -----------------------------
" Backups / swaps / undo
" -----------------------------
if !isdirectory(expand('~/.vim/tmp/backup'))
  call mkdir(expand('~/.vim/tmp/backup'), 'p')
endif
if !isdirectory(expand('~/.vim/tmp/swap'))
  call mkdir(expand('~/.vim/tmp/swap'), 'p')
endif

set backup
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undofile
set undodir=~/.vim/tmp/undo//

" -----------------------------
" Notes:
" - Removed: Vundle, CtrlP, Syntastic, flake8 plugin, pydoc.vim, old python indent,
"            NERDTree (optional), deprecated autoclose, debugger keymaps.
" - fzf respects .gitignore; ripgrep greatly speeds up search.
" - ALE expects external tools: pip install black ruff mypy; npm i -g prettier eslint; Go ships gofmt.
" -----------------------------
"
