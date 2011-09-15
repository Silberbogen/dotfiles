set nocompatible
set expandtab
set shiftwidth=4
"set softtabstop=4
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
  colorscheme delek
"  colorscheme pablo
"  set background=dark
"  colorscheme solarized
"  colorscheme pablo
endif

