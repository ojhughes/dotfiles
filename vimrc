let mapleader=','

call plug#begin('~/.vim/plugged')

Plug 'stephpy/vim-yaml'
Plug 'crusoexia/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
"syntax configuration
syntax on
filetype plugin indent on
set nocompatible
set t_Co=256

set cursorline
set laststatus=2
set number
set showmode
set showcmd
set showmatch
set title
set backspace=indent,eol,start
set nostartofline
set hlsearch
set incsearch
set ignorecase smartcase
set ttyfast
set number
set expandtab
set autoindent
set copyindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set wrap
set textwidth=120
set formatoptions=qrn1
set formatoptions-=o
set pastetoggle=<F12>
set wildmenu                " Hitting TAB in command mode will
set wildchar=<TAB>          "   show possible completions.
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif
vmap <D-c> "+y
autocmd FileType yaml set autoindent shiftwidth=2 softtabstop=2 expandtab wrap linebreak textwidth=90 nolist
call plug#end()
colorscheme monokai
