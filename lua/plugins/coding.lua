-- ============================================================================
-- Coding Plugins
-- Completion, snippets, treesitter
-- ============================================================================

local not_vscode = not vim.g.vscode -- VSCode handles completion; keep treesitter for text objects

return {
  -- Treesitter: Better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Core
          "bash",
          "c",
          "lua",
          "vim",
          "markdown",
          "markdown_inline",
          -- Web
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "tsx",
          "vue",
          "json",
          "yaml",
          "toml",
          -- Languages
          "go",
          "python",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },

  -- Autocompletion: blink.cmp (modern, faster alternative to nvim-cmp)
  {
    "saghen/blink.cmp",
    cond = not_vscode,
    version = "*", -- Use latest stable release for API stability
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet engine + community snippets
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    opts = {
      -- Use LuaSnip as snippet engine
      snippets = { preset = "luasnip" },

      -- Keymap: super-tab (Tab selects/accepts/expands) + Enter to confirm
      keymap = {
        preset = "super-tab",
        ["<CR>"]  = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      -- Appearance: inherit nvim-cmp highlight groups (Catppuccin compat)
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        -- Auto-insert brackets after function/method completions
        accept = { auto_brackets = { enabled = true } },

        -- Ghost text (inline preview of top suggestion)
        ghost_text = { enabled = true },

        -- Documentation popup
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "rounded" },
        },

        -- Completion menu
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" }, -- use treesitter highlighting in menu
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
      },

      -- Sources: LSP, path, snippets, buffer
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- Cmdline completion (API v1: top-level key, not sources.cmdline)
      cmdline = {
        sources = { "cmdline" },
      },

      -- Inline signature help (replaces nvim-cmp's signature popup)
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
