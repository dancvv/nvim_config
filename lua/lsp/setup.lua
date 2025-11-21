-- ============================================================================
-- LSP Setup
-- Configure all language servers
-- ============================================================================

local M = {}

-- Setup LSP servers
function M.setup()
  -- Setup handlers and diagnostics
  require("lsp.handlers").setup()

  -- Setup keymaps
  require("lsp.keymaps").setup()

  -- Setup mason-lspconfig
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")

  -- Get default capabilities
  local capabilities = require("lsp.handlers").capabilities

  -- Server configurations
  local servers = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },

    ts_ls = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },

    volar = {
      filetypes = { "vue", "typescript", "javascript" },
      settings = {
        vue = {
          hybridMode = false,
        },
      },
    },

    gopls = {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    },

    pyright = {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    },

    html = {},
    cssls = {},
    jsonls = {},
    yamlls = {},
    tailwindcss = {},
    eslint = {},
  }

  -- Setup handlers for mason-lspconfig
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  })

  mason_lspconfig.setup_handlers({
    -- Default handler
    function(server_name)
      local opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = capabilities,
      }

      -- Merge server-specific settings
      if servers[server_name] then
        opts = vim.tbl_deep_extend("force", opts, servers[server_name])
      end

      lspconfig[server_name].setup(opts)
    end,
  })
end

return M
