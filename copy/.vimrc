"Undo vi compatibility
set nocompatible

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

" required for vundle
filetype on " required for Mac system VIM
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" Plugins from GitHub repos:

" Solarized theme
Plugin 'altercation/vim-colors-solarized'
" Terminal Vim with 256 colors colorscheme
"Plugin 'fisadev/fisa-vim-colorscheme'

" Python and PHP Debugger
"Plugin 'fisadev/vim-debug.vim'
" Better file browser
Plugin 'scrooloose/nerdtree'
" Code commenter
Plugin 'scrooloose/nerdcommenter'
" Class/module browser
"Plugin 'majutsushi/tagbar'
" Code and files fuzzy finder
Plugin 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'
" Git integration
Plugin 'tpope/vim-fugitive'
" Airline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Surround
Plugin 'tpope/vim-surround'
" Autoclose
Plugin 'Townk/vim-autoclose'
" Indent text object
Plugin 'michaeljsmith/vim-indent-object'
" Python autocompletion and documentation
Plugin 'davidhalter/jedi-vim'
" Snippets manager UltiSnips and snippets repo
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Git diff icons on the side of the file lines
Plugin 'airblade/vim-gitgutter'
" Better python indentation
Plugin 'vim-scripts/indentpython.vim--nianyang'
" PEP8 and python-flakes checker
Plugin 'nvie/vim-flake8'
" Search and read python documentation
Plugin 'fs111/pydoc.vim'
" Syntax checking for many languages
Plugin 'scrooloose/syntastic'
" Support virtualenv for Python
Plugin 'jmcantrell/vim-virtualenv'
" Go development plugin
Plugin 'fatih/vim-go'
" TypeScript development Plugin
Plugin 'HerringtonDarkholme/yats.vim'

" Plugins from vim-scripts repos

" Autocompletion
Plugin 'AutoComplPop'
" Search results counter
Plugin 'IndexedSearch'
" XML/HTML tags navigation
Plugin 'matchit.zip'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

call vundle#end()

" allow plugins by file type
filetype plugin on
filetype indent on

" Encoding default
set encoding=utf-8

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2

" always show status bar
set laststatus=2

" incremental search
"set incsearch

" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" highlight trailing whitespace
let c_space_errors = 1
let javascript_space_errors = 1

" line numbers
set number

" indent stuff
set smartindent
set autoindent

" better line wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

" automatically change current directory to that of the file in the buffer
autocmd BufEnter * cd %:p:h

" Setup virtualenv Support
let g:virtualenv_directory = '~/Virtualenvs'

" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" fix some problems with gitgutter and jedi-vim
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" automatically close autocompletion window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" removes trailing spaces of python files
" (and restores cursor position)
autocmd BufWritePre *.py mark z | %s/\s\+$//e | 'z

" save as sudo
"ca w!! w !sudo tee "%"

" colors and settings of autocompletion
highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black

" debugger keyboard shortcuts
let g:vim_debug_disable_mappings = 1
map <F5> :Dbg over<CR>
map <F6> :Dbg into<CR>
map <F7> :Dbg out<CR>
map <F8> :Dbg here<CR>
map <F9> :Dbg break<CR>
map <F10> :Dbg watch<CR>
map <F11> :Dbg down<CR>
map <F12> :Dbg up<CR>

" CtrlP (new fuzzy finder)
let g:ctrlp_map = ',e'
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction


" CtrlP with default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep 
nmap ,r :RecurGrepFast 
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

" run pep8+pyflakes validator
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
" rules to ignore (example: "E501,W293")
let g:flake8_ignore=""

" jedi-vim customizations
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = ",a"
let g:jedi#goto_definitions_command = ",d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ",o"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
nmap ,D :tab split<CR>,d

" Change snipmate binding, to avoid problems with jedi-vim
"imap <C-i> <Plug>snipMateNextOrTrigger

" UltiSnips controls
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" tabman shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|screen-256'
	let &t_Co = 256
    " color
    " colorscheme fisa
    set background=dark
    colorscheme solarized
else
    " color
    colorscheme delek
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#whitespace#enabled = 0

" Just display branches, not hunks as well
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" backups
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

" Set sign column to match line number column
highlight clear SignColumn
