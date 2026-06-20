-- ~/.config/nvim/init.lua
-- Config minimalista orientada a Angular (TS/HTML/SCSS) y trabajo con agentes de código.
-- Estructura: config/ (opciones, keymaps) + plugins/ (cada plugin en su archivo) cargados por lazy.nvim.

require("config.options")
require("config.keymaps")
require("config.lazy")
