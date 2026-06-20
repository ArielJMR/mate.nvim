-- Opciones base del editor
local opt = vim.opt

-- Interfaz
opt.number = true            -- números de línea
opt.relativenumber = true    -- relativos (útil para moverse con jk + count)
opt.signcolumn = "yes"       -- columna fija para signos LSP/git (evita saltos)
opt.cursorline = true
opt.termguicolors = true     -- colores 24-bit
opt.scrolloff = 6
opt.wrap = false
opt.mouse = "a"

-- Indentación (2 espacios, estándar Angular/TS)
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true

-- Búsqueda
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Archivos / undo persistente
opt.swapfile = false
opt.undofile = true          -- deshacer persistente entre sesiones
opt.updatetime = 250         -- diagnósticos LSP más reactivos

-- Portapapeles del sistema (copy/paste con Cmd+C/V)
opt.clipboard = "unnamedplus"

-- Splits más naturales
opt.splitright = true
opt.splitbelow = true

-- Importante al trabajar con agentes que editan archivos en disco:
-- recargar automáticamente si el archivo cambió fuera de Neovim.
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
