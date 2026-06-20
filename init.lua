-- mate.nvim — Neovim como IDE completo (TS/Angular/HTML/SCSS + Java).
-- Pensada para sentirse como WebStorm/VSCode/Zed pero sobre Neovim.
-- Estructura: config/ (opciones, keymaps) + plugins/ (cada plugin en su archivo) cargados por lazy.nvim.

require("config.options")
require("config.keymaps")
require("config.lazy")
