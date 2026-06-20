# 🧉 mate.nvim

Una configuración de **Neovim como IDE completo** — pensada para sentirse como WebStorm, VSCode, Zed o IntelliJ, pero rápida y sin mouse. Enfocada en desarrollo web (TypeScript, Angular, HTML, SCSS) y Java, sobre [lazy.nvim](https://github.com/folke/lazy.nvim).

> _mate_: el compañero inseparable de las horas de código. Y, de paso, tu _mate_ (partner) editando.

## ✨ Qué trae

- **Gestor de plugins**: lazy.nvim con bootstrap automático — cloná y abrí, el resto se instala solo.
- **LSP listo de fábrica**: Angular, TypeScript/JS, HTML, CSS/SCSS, JSON, ESLint, Java (jdtls) y Lua — instalados vía [Mason](https://github.com/williamboman/mason.nvim). Enable manual con `vim.lsp.enable()` + `root_markers` por servidor (Neovim 0.11+), pensado para monorepos (Nx) y proyectos Bun.
- **Navegación tipo IDE**: Telescope (quick-open `<C-p>`, grep, símbolos del proyecto) + árbol de archivos (nvim-tree) que se abre solo al entrar a una carpeta.
- **Sintaxis precisa**: Treesitter.
- **Edición ágil**: autopairs, autotag (cierre de tags HTML/Angular), Comment.nvim, gitsigns.
- **Autocompletado**: nvim-cmp + LuaSnip.
- **Formateo**: conform.nvim con Prettier (`<leader>cf`).
- **Apariencia**: tokyonight + lualine.
- **Diseñada para trabajar junto a agentes de código**: `autoread` + `checktime` recargan los archivos cuando un agente los edita en disco.

## 📦 Instalación

```bash
git clone https://github.com/ArielJMR/mate.nvim ~/.config/nvim
nvim
```

lazy.nvim instala todos los plugins en el primer arranque. Mason descarga los LSP en segundo plano.

> ¿Ya tenés una config de Neovim? Cloná en otro lado y usá el helper, que hace backup automático:
>
> ```bash
> git clone https://github.com/ArielJMR/mate.nvim ~/mate.nvim
> ~/mate.nvim/install.sh   # mueve tu ~/.config/nvim a .bak y enlaza esta
> ```

## ⌨️ Atajos clave (leader = `espacio`)

| Atajo        | Acción                           |
| ------------ | -------------------------------- |
| `<C-p>`      | Quick open (buscar archivos)     |
| `<leader>ff` | Buscar archivos                  |
| `<leader>fg` | Buscar texto (grep)              |
| `<leader>fs` | Símbolos del archivo             |
| `<leader>fS` | Símbolos del proyecto            |
| `<leader>n`  | Explorador de archivos           |
| `<leader>cf` | Formatear                        |
| `<leader>w`  | Guardar                          |
| `<leader>rn` | Renombrar símbolo (LSP)          |
| `<leader>ca` | Acción de código (LSP)           |
| `gd` / `gr`  | Ir a definición / referencias    |
| `K`          | Documentación bajo el cursor     |
| `[d` / `]d`  | Diagnóstico anterior / siguiente |

## 🔧 Dependencias

- **Neovim ≥ 0.11**
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) y [`fd`](https://github.com/sharkdp/fd) — para Telescope (`brew install ripgrep fd`)
- **JDK 17** para el LSP de Java (`brew install openjdk@17`)
- Una [Nerd Font](https://www.nerdfonts.com/) para los íconos.

## 🗂️ Estructura

```
mate.nvim/
├── init.lua              # punto de entrada
├── lua/
│   ├── config/
│   │   ├── options.lua   # opciones del editor
│   │   ├── keymaps.lua   # atajos
│   │   └── lazy.lua      # bootstrap de lazy.nvim
│   └── plugins/
│       ├── editor.lua    # Telescope, nvim-tree, Treesitter, git, pares
│       ├── lsp.lua       # Mason + LSP + cmp + conform
│       └── ui.lua        # tema, statusline, íconos
└── lazy-lock.json        # versiones fijadas (reproducibilidad)
```

## 📄 Licencia

[MIT](./LICENSE) — usala, forkeala, adaptala.
