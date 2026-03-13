-- ============================================================================
-- LSP Configuration
-- Language Server Protocol setup with mason
-- ============================================================================

-- VSCode provides its own LSP client; skip all LSP plugins in VSCode
if vim.g.vscode then return {} end

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- lazydev replaces neodev.nvim (Neovim 0.10+)
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when vim.uv is used
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      -- luvit-meta: type defs for vim.uv / libuv
      { "Bilal2453/luvit-meta", lazy = true },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- blink.cmp must load before LSP to provide enhanced capabilities
      "saghen/blink.cmp",
    },
    config = function()
      -- Load LSP configuration
      require("lsp.setup")
    end,
  },

  -- Mason: Portable package manager for LSP servers, DAP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = function()
      local ok, icons = pcall(require, "ui.icons")
      local mason_icons = ok and icons.mason or {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
      return {
        ui = {
          border = "rounded",
          icons = mason_icons,
        },
      }
    end,
  },

  -- Tool installer: manages LSP servers, formatters, and linters via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP Servers
        "lua-language-server",
        "typescript-language-server",
        "vue-language-server",
        "tailwindcss-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "yaml-language-server",
        "gopls",
        "pyright",
        "eslint-lsp",
        -- Formatters
        "stylua",
        "prettier",
        "prettierd",
        "black",
        "isort",
        "gofumpt",
        "goimports",
        -- Linters
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
  },

  -- Formatting
  -- Note: Auto-format on save is DISABLED by default
  -- Use <leader>fm to manually format the buffer
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        vue = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        go = { "goimports", "gofumpt" },
      },
      -- Disable format on save - use <leader>fm to format manually
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
