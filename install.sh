#!/usr/bin/env bash
# Crea los symlinks de la config de Vim/Neovim hacia este repo.
# Hace backup (con sufijo .bak) de cualquier archivo/carpeta existente que no sea ya el symlink correcto.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  # Ya está correctamente enlazado: nada que hacer.
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok    $dest -> $src"
    return
  fi
  # Existe algo distinto: backup antes de pisar.
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "backup $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link  $dest -> $src"
}

link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link "$DOTFILES_DIR/nvim"   "$HOME/.config/nvim"

echo "Listo. Abrí nvim para que lazy.nvim instale los plugins."
