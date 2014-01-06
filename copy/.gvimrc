" set typeface and size
if has("gui_gtk2")
    set guifont=Menlo for Powerline 10
elseif has("gui_macvim")
    set guifont=Menlo\ Regular\ for\ Powerline:h13
endif

" set linespacing
set linespace=3

" colors for gvim
colorscheme wombat

" Remove the toolbar
set guioptions-=T
