#!/usr/bin/env bash
# Instala mate.nvim enlazando este repo a ~/.config/nvim.
# Hace backup (con sufijo .bak) de cualquier config de Neovim existente.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.config/nvim"

# Ya está correctamente enlazado: nada que hacer.
if [ -L "$DEST" ] && [ "$(readlink "$DEST")" = "$REPO_DIR" ]; then
  echo "ok    $DEST -> $REPO_DIR"
  exit 0
fi

# Existe una config previa: backup antes de pisar.
if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  echo "backup $DEST -> $DEST.bak"
  mv "$DEST" "$DEST.bak"
fi

mkdir -p "$(dirname "$DEST")"
ln -s "$REPO_DIR" "$DEST"
echo "link  $DEST -> $REPO_DIR"
echo "Listo. Abrí nvim para que lazy.nvim instale los plugins."
