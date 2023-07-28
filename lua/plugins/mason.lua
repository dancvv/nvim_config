local M = {
    { "williamboman/mason.nvim" ,
       ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
       },
    { "williamboman/mason-lspconfig.nvim",
      ensure_installed = { "lua_ls", "rust_analyzer" },
    },
    { "neovim/nvim-lspconfig" },
}

return M
