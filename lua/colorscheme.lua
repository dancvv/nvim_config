vim.o.background = "dark"
-- setting the color theme
local colorscheme = "tokyonight-moon"
local status_ok, scheme = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- local status_ok, scheme = pcall(require, "tokyonight")
-- tell the terminal whether find the theme
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end

