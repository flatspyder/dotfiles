" set typeface and linespacing
if has("gui_gtk2")
    set guifont=Hack\ 11
    set linespace=2
elseif has("gui_macvim")
    set guifont=Menlo\ Regular\ for\ Powerline:h13
    set linespace=2
endif

set background=dark
colorscheme solarized

" Remove the toolbar
set guioptions-=T
