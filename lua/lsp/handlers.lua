-- ============================================================================
-- LSP Handlers
-- Configure LSP behavior, diagnostics, and capabilities
-- ============================================================================

local M = {}

-- Setup LSP handlers
function M.setup()
  local ok, icons = pcall(require, "ui.icons")
  if not ok then
    icons = { diagnostics = { error = "E", warn = "W", hint = "H", info = "I" } }
  end

  -- Configure diagnostics (Neovim 0.10+ signs API - replaces vim.fn.sign_define)
  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
        [vim.diagnostic.severity.WARN]  = icons.diagnostics.warn,
        [vim.diagnostic.severity.HINT]  = icons.diagnostics.hint,
        [vim.diagnostic.severity.INFO]  = icons.diagnostics.info,
      },
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

  -- Configure hover and signature help borders
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- Suppress noisy LSP notifications
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

-- LSP capabilities: blink.cmp provides enhanced capabilities (replaces cmp_nvim_lsp)
-- blink.get_lsp_capabilities() already merges with base capabilities internally
local has_blink, blink = pcall(require, "blink.cmp")
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  has_blink and blink.get_lsp_capabilities() or {}
)

-- On attach function (called when LSP attaches to buffer)
function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

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

  -- Enable inlay hints if available (0.10+ new API signature)
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

return M
