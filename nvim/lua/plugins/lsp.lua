-- LSP (Angular, TypeScript, HTML, CSS/SCSS, JSON, ESLint) + Mason para instalar servidores
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "angularls",   -- Angular Language Server
          "ts_ls",       -- TypeScript / JavaScript (cubre Elysia.js / Bun)
          "html",
          "cssls",
          "jsonls",
          "eslint",
          "jdtls",       -- Java (Eclipse JDT)
          "lua_ls",      -- Lua (para editar esta misma config)
        },
        -- El enable de los servidores lo hacemos manual abajo con vim.lsp.enable()
        -- para poder aplicar root_markers/settings por servidor primero.
        automatic_enable = false,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      -- Atajos comunes al adjuntar un servidor LSP a un buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function m(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
          end
          m("gd", vim.lsp.buf.definition, "Ir a definición")
          m("gr", vim.lsp.buf.references, "Referencias")
          m("gi", vim.lsp.buf.implementation, "Implementación")
          m("K", vim.lsp.buf.hover, "Documentación")
          m("<leader>rn", vim.lsp.buf.rename, "Renombrar símbolo")
          m("<leader>ca", vim.lsp.buf.code_action, "Acción de código")
          m("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Diagnóstico anterior")
          m("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Diagnóstico siguiente")
        end,
      })

      -- Capacidades extendidas para autocompletado (nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configuración por servidor con la API nativa vim.lsp.config (Neovim 0.11+)
      vim.lsp.config("*", { capabilities = capabilities })

      -- Angular: limitar a proyectos Angular reales (evita arrancar en cualquier dir)
      vim.lsp.config("angularls", {
        root_markers = { "angular.json", "nx.json" },
      })

      -- TypeScript: detectar la raíz correcta en monorepos Nx y proyectos Bun/Elysia.
      vim.lsp.config("ts_ls", {
        root_markers = { "tsconfig.json", "package.json", "bun.lockb", "bun.lock", "nx.json", ".git" },
      })

      -- Java (jdtls): apuntar al JDK 17 que tenés en Homebrew.
      vim.lsp.config("jdtls", {
        root_markers = { "pom.xml", "build.gradle", "settings.gradle", ".git" },
        cmd_env = { JAVA_HOME = "/opt/homebrew/opt/openjdk@17" },
      })

      -- Lua: reconocer la API global `vim` (evita warnings en esta config).
      vim.lsp.config("lua_ls", {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- Habilitar los servidores instalados por Mason
      vim.lsp.enable({
        "angularls", "ts_ls", "html", "cssls", "jsonls",
        "eslint", "jdtls", "lua_ls",
      })
    end,
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Formateo (Prettier para Angular/TS/HTML/SCSS si está en el proyecto)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Formatear" },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          typescript = { "prettier" },
          javascript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          json = { "prettier" },
          -- Java se formatea vía el LSP (jdtls) con el fallback de <leader>f.
        },
        -- No formatea solo al guardar por defecto (usá <leader>f); cambialo si querés auto-format.
        format_on_save = nil,
      })
    end,
  },
}
