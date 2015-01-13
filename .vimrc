set encoding=utf-8

" Pathon aufrufen
call pathogen#infect()  
call pathogen#helptags()

" Dies ist Vim, nicht vi
set nocompatible

" Für GO
set rtp+=$GOROOT/misc/vim

" Syntax-Hervorhebung
syntax on

" Dateiart erkennen
filetype on

" Dateitypische Einrückregeln
filetype indent on

" Enable file-specific plugins
filetype plugin on

set autoindent 			" auto indent
set relativenumber 		" show relative line numbers
set expandtab 			" use spaces, not tab characters
set showmatch 			" show bracket matches
set ignorecase 			" ignore case in search
set hlsearch 			" highlight all search matches
set cursorline 			" highlight current line
set smartcase 			" pay attention to case when caps are used
set incsearch 			" show search results as I type
set mouse=a 			" enable mouse support
set ttimeoutlen=100 		" decrese timeout for faster insert with 'O'
set vb 				" enable visual bell (disable audio bell)
set ruler 			" show row and column in footer
set scrolloff=2 		" minimum lines above/below cursor
set laststatus=2 		" always show status bar
set nofoldenable 		" disable code folding
set clipboard=unnamed 		" use system clipboard
set wildmenu 			" enable bash style tab completion
set wildmode=list:longest,full
set t_Co=256
"set t_ut=y

" hint to keep lines short
if exists('+colorcolumn')
	set colorcolumn=80
endif

if has('gui_running')
    set background=light
    let g:solarized_contrast = "high"
    let g:solarized_visibility= "high"
    colorscheme solarized
    "colorscheme molokai
    "colorscheme liquidcarbon
else
    "let g:solarized_termcolors=256
    "set background=light
    "colorscheme solarized
    colorscheme molokai
    "colorscheme jellybeans
    "colorscheme github256
    "colorscheme zenburn
endif

" Tab preferences based on filetype
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype c setlocal ts=4 sw=4 expandtab
autocmd Filetype cpp setlocal ts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 expandtab
autocmd Filetype java setlocal ts=4 sw=4 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab

set statusline=%F%m%r%h%w\ \ [%l,%c]\ [%L,%p%%]
