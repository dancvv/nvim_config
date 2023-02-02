local status, mason = pcall(require, "mason")
if not status then
  vim.notify( "Not found mason plugin" )
  return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify( "Not found mason-lspconfig plugin" )
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify( "Not found lspconfig plugin" )
  return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua" },
}

-- install list
local servers = {
  sumneko_lua = require("lsp.config.lua"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

-- introduce ui config
require('lsp.ui')
