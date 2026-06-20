-- Herramientas de navegación y edición: buscador, file tree, treesitter, git, pares
return {
  -- Telescope: buscar archivos y texto (usa ripgrep + fd)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- "Search Everywhere" estilo IntelliJ/VS Code (funciona en modo normal e insert):
      { "<C-p>", "<cmd>Telescope find_files<CR>", mode = { "n", "i" }, desc = "Buscar archivos (quick open)" },
      -- Símbolos (funciones/clases), como el Search Everywhere de IntelliJ:
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Símbolos del archivo" },
      { "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Símbolos del proyecto" },
      -- Resto del set de búsqueda:
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto (grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers abiertos" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Archivos recientes" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnósticos" },
    },
    config = function()
      -- Ignorar carpetas pesadas: clave en monorepos Nx y proyectos Java/Bun.
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules", "%.nx/", "dist/", "build/", "target/",
            "%.angular/", "coverage/", "%.git/",
          },
        },
        pickers = {
          find_files = { hidden = true }, -- incluir dotfiles (ej. .env.example)
        },
      })
    end,
  },

  -- File explorer (panel lateral, estilo VS Code)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- cargar al inicio para poder auto-abrir el árbol
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Explorador de archivos" },
    },
    config = function()
      require("nvim-tree").setup({
        actions = { open_file = { quit_on_open = false } },
        update_focused_file = { enable = true }, -- resalta el archivo actual en el árbol
        view = { width = 32 },
      })

      -- Abrir el árbol automáticamente al iniciar nvim en una carpeta (como VS Code),
      -- dejando el cursor en la ventana de edición (no en el árbol).
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local is_dir = vim.fn.isdirectory(data.file) == 1
          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
          if is_dir or no_name then
            require("nvim-tree.api").tree.open()
            -- volver el foco al editor si se abrió un archivo/carpeta concreto
            if is_dir then
              vim.cmd.cd(data.file)
            else
              vim.cmd("wincmd p")
            end
          end
        end,
      })
    end,
  },

  -- Treesitter: resaltado de sintaxis preciso para Angular/TS/HTML/SCSS
  -- Anclado a la rama master (API estable con .configs.setup); la rama main aún cambia.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "typescript", "javascript", "tsx", "html", "css", "scss",
          "json", "lua", "vim", "vimdoc", "markdown", "bash", "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
    end,
  },

  -- Cerrar pares y etiquetas HTML automáticamente (clave para templates Angular)
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "typescript", "typescriptreact", "javascript", "xml" },
    config = true,
  },

  -- Indicadores de git en la columna lateral
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Comentar líneas con gcc / gc en visual
  { "numToStr/Comment.nvim", config = true },
}
