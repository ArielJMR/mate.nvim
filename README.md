# dotfiles

Configuración de editores (Vim + Neovim) versionada.

## Contenido

| Ruta     | Symlink en el sistema | Descripción                                                    |
| -------- | --------------------- | -------------------------------------------------------------- |
| `.vimrc` | `~/.vimrc`            | Config minimalista de Vim clásico (ediciones rápidas).         |
| `nvim/`  | `~/.config/nvim`      | Neovim con lazy.nvim, orientado a Angular/TS/HTML/SCSS + Java. |

## Neovim — qué incluye

- **Gestor de plugins**: lazy.nvim (bootstrap automático).
- **LSP**: Angular, TypeScript/JS, HTML, CSS/SCSS, JSON, ESLint, Java (jdtls), Lua — instalados vía Mason. Enable manual con `vim.lsp.enable()` + `root_markers` por servidor (Neovim 0.11+).
- **Búsqueda**: Telescope (requiere `ripgrep` + `fd`).
- **Sintaxis**: Treesitter.
- **Edición**: autopairs, autotag (HTML/Angular), Comment.nvim, gitsigns.
- **Autocompletado**: nvim-cmp + LuaSnip.
- **Formateo**: conform.nvim (Prettier) — `<leader>cf`.
- **UI**: tokyonight + lualine.

### Atajos clave (leader = espacio)

| Atajo        | Acción                        |
| ------------ | ----------------------------- |
| `<C-p>`      | Quick open (buscar archivos)  |
| `<leader>ff` | Buscar archivos               |
| `<leader>fg` | Buscar texto (grep)           |
| `<leader>fs` | Símbolos del archivo          |
| `<leader>n`  | Explorador de archivos        |
| `<leader>cf` | Formatear                     |
| `<leader>w`  | Guardar                       |
| `gd` / `gr`  | Ir a definición / referencias |

## Instalación en una máquina nueva

```bash
git clone <url-del-repo> ~/dotfiles
~/dotfiles/install.sh
```

El script crea los symlinks (haciendo backup de cualquier config existente).

## Dependencias

- Neovim ≥ 0.11
- `ripgrep` y `fd` (`brew install ripgrep fd`)
- JDK 17 para Java LSP (`brew install openjdk@17`)
- Una Nerd Font para los íconos de nvim-web-devicons.
