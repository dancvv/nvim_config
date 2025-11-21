-- ============================================================================
-- LSP Handlers
-- Configure LSP behavior, diagnostics, and capabilities
-- ============================================================================

local M = {}

-- Setup LSP handlers
function M.setup()
  local icons = require("ui.icons")

  -- Configure diagnostic signs
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.warn },
    { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- Configure diagnostics
  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Configure hover and signature help
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Disable LSP progress notifications (reduces clutter)
  vim.lsp.handlers["$/progress"] = function() end

  -- Suppress other noisy LSP notifications
  local notify = vim.notify
  vim.notify = function(msg, level, opts)
    if msg and type(msg) == "string" then
      if msg:match("warning: multiple different client offset_encodings") then
        return
      end
      if msg:match("method .+ is not supported by any of the servers") then
        return
      end
    end
    notify(msg, level, opts)
  end
end

-- LSP capabilities with nvim-cmp
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Enhanced with cmp_nvim_lsp
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

-- On attach function (called when LSP attaches to buffer)
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Highlight symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Enable inlay hints if available
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

return M
