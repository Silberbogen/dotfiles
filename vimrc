set encoding=utf-8
set termencoding=utf-8
set nocompatible
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set ai
set cin
syntax enable
if has('gui_running')
    let g:solarized_contrast="high"    "default value is normal
    let g:solarized_visibility="high"    "default value is normal
    let g:solarized_diffmode="high"    "default value is normal
    set background=dark
    colorscheme solarized
else
    colorscheme zenburn
endif
"set spelllang=de_de spell

set autowrite
set writebackup
set backup
set backupdir=$HOME/.vim/backup/,/tmp
set directory=$HOME/.vim/backup/,/tmp

" search options
set hlsearch
set incsearch
set ignorecase
set smartcase

"{{{ Folding test
if has("folding")
    set foldenable
    set foldmethod=marker
    set foldmarker={{{,}}}
    set foldcolumn=0
    set foldlevel=100
endif
"}}}

if v:version >= 703
    set undodir=~/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

