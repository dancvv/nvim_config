local status, mason = pcall(require, "mason")
if not status then
  vim.notify( "Not found mason plugin" )
  return
end

local status, mason_config = pcall(require, "mason_config")
if not status then
  vim.notify( "Not found mason_config plugin" )
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

mason_config.setup {
    ensure_installed = { "sumneko_lua", "rust_analyzer" },
}

-- install list
local servers = {
  sumneko_lua = require("lsp.config.lua")
}

--for name, config in pairs(servers) do
--  if config ~= nil and type(config) == "table" then
--    -- auto config on_setup method
--    config.on_setup(lspconfig[name])
--  else
--    -- use default args
--    lspconfig[name].setup({})
--  end
--end

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end
