-- ============================================================================
-- LSP Keymaps
-- Key mappings for LSP functionality
-- ============================================================================

local M = {}

function M.setup()
  -- Create autocmd for setting keymaps when LSP attaches
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }

      -- Navigation
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
      vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Go to references" }))
      vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

      -- Hover and signature help
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

      -- Code actions
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

      -- Formatting
      vim.keymap.set("n", "<leader>fm", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", opts, { desc = "Format document" }))

      -- Diagnostics
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
      vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
      vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", vim.tbl_extend("force", opts, { desc = "List diagnostics" }))

      -- Workspace
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

      -- Document symbols
      vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", vim.tbl_extend("force", opts, { desc = "Document symbols" }))
      vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

      -- Inlay hints toggle
      if vim.lsp.inlay_hint then
        vim.keymap.set("n", "<leader>uh", function()
          vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
        end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
      end
    end,
  })
end

return M
