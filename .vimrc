" ~/.vimrc — config minimalista para ediciones rápidas
set nocompatible          " comportamiento moderno, no Vi clásico
syntax on                 " resaltado de sintaxis
filetype plugin indent on " detección de tipo de archivo + indentado

" --- Interfaz ---
set number                " números de línea
set ruler                 " posición del cursor en la barra
set showcmd               " muestra comandos a medio escribir
set wildmenu              " autocompletado en la línea de comandos :
set mouse=a               " soporte de ratón (familiar viniendo de GUIs)

" --- Búsqueda ---
set incsearch             " busca mientras escribís
set hlsearch              " resalta coincidencias
set ignorecase            " ignora mayúsculas...
set smartcase             " ...salvo que escribas alguna mayúscula

" --- Indentación (2 espacios, típico en JS/TS/web) ---
set expandtab             " tabs -> espacios
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" --- Calidad de vida ---
set clipboard=unnamed     " usa el portapapeles del sistema (copy/paste con Cmd+C/V)
set backspace=indent,eol,start
set scrolloff=4           " margen al hacer scroll
set ttimeoutlen=50        " menos lag al pulsar Esc

" Limpiar resaltado de búsqueda con Esc (igual que en la config de Neovim)
nnoremap <Esc> :nohlsearch<CR>
