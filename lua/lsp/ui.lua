vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  -- 输入模式下也进行更新提示，设置为true可能会影响性能
  update_in_insert = true,
})
local signs = local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type,icon in pairs(signs) do
  local hl = "Diagnostic" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl})
end
