syntax on
set number
colorscheme onedark
set hlsearch

# plugins
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'vim-airline/vim-airline'
call plug#end()

# Set the f2 key to toggle nerd tree
:map <F2> :NERDTreeToggle<CR>
