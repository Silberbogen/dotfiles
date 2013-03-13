" Syntax-Hervorhebung
syntax on
" Syntax-Hervorhebung an dunklen Hintergrund anpassen
set background=dark
" automatische Zeileneinrueckung
set autoindent
set smartindent
set shiftwidth=4
" Ruecktaste loescht Tab, 4 Leerzeichen 
set softtabstop=4
" Sprachenerkennung aktivieren
filetype plugin indent on
" Tabs durch Leerzeichen ersetzen lassen
set expandtab
" Tab auf 4 Zeichen setzen
set tabstop=4
" Gross-/Kleinschreibung ignorieren
set ignorecase
" Gross-/Kleinschreibung nicht ignorieren, 
" wenn Grossbuchstaben im Suchbegriff
set smartcase
" Zeile/Spalte anzeigen
set ruler 
" Vervollstaendigungsoptionen als Menue anzeigen
set wildmenu
" vi-Kompatibilitaets-Modus deaktivieren
set nocp
" Clipboard verwenden
set clipboard=unnamed
 
""" Tastenkuerzel festlegen
" automatisches Einruecken deaktivieren
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
"   aktuelles Pythonscript testen
map <F3> :!python3 -d %  <return>
map <F4> :set cursorline <return>              
"   deutsche Rechtschreibung waehrend der Eingabe ueberpruefen
map <F5> :!idle3 -s -r % <return>
map <F6> :!bpython3 -i % <return>
map <F8>  :setlocal spell spelllang=de <return>
"   deutsche Rechtschreibung mit Aspell ueberpruefen (aspell-de)
map <F7> :w!<CR>:!aspell check %<CR>:e! %<CR>
 
""" Standard-Eintraege
if has("autocmd")
    filetype indent on
endif
 
if has("autocmd")
    autocmd FileType python set complete+=k~/.vim/pydiction-0.5/pydiction isk+=.,(
endif 
 
set viminfo='10,\"100,:20,%,n~/.viminfo
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Schriftart/ -groesse setzen
set guifont=Dejavu\ Sans\ Mono\ 10
" Farbschema setzen:
"  - via: http://www.vim.org/scripts/script.php?script_id=2555
"  - in ~/.vim/colors/ ablegen
colorscheme jellybeans
 
" Menueleisten, Scrollleisten nicht anzeigen
set guioptions-=r
set guioptions-=m
set guioptions-=T
 
" mit F9 Anzeige der Leisten umschalten
let g:menubar=0
map <silent> <F9> :if g:menubar == 1<CR>:set guioptions-=mT<CR>:let g:menubar = 0<CR>
  \ :else<CR>:set guioptions+=mT<CR>:let g:menubar = 1<CR>:endif<CR>
 
