-- Atajos de teclado (leader = espacio)
local map = vim.keymap.set

-- Limpiar resaltado de búsqueda
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Guardar / salir rápido
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Guardar" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Cerrar ventana" })

-- Recargar archivo desde disco (útil tras edición de un agente)
map("n", "<leader>e", "<cmd>edit!<CR>", { desc = "Recargar archivo desde disco" })

-- Moverse entre ventanas (splits) con Ctrl + hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Mover líneas seleccionadas en modo visual
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover selección abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover selección arriba" })

-- Mantener cursor centrado al saltar medio-página y buscar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
