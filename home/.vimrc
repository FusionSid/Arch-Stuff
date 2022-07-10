syntax on
set number
colorscheme onedark
set hlsearch

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'vim-airline/vim-airline'
call plug#end()

map <F2> :NERDTreeToggle<CR>

set expandtab ts=4 sw=4 ai
autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set backspace=indent,eol,start
