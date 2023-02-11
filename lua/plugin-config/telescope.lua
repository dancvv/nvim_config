local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("Not found telescope")
  return
end

-- load file_browser extension
local fb_status, _  = pcall(telescope.load_extension, "file_browser")
if not fb_status then
  vim.notify("Load extension telescope file_browser failed")
  return
end

-- load projects extension
local pj_status, _ = pcall(telescope.load_extension, "project")
if not pj_status then
  vim.notify("Load extension project failed")
  return
end

-- load env extension
local env_status, _ = pcall(telescope.load_extension, "env")
if not env_status then
  vim.notify("Load extension env failed")
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
  },
  pickers = {
    -- 内置 pickers 配置
    find_files = {
      -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
      -- theme = "dropdown", 
    }
  },
  extensions = {
     -- 扩展插件配置
     project = {
       hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = true, -- default false
     }
  },
})

