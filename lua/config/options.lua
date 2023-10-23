-- utf8 encoding
vim.g.encoding = "UTF-8"

vim.g.autoformat = true
vim.wo.cursorline = true
-- leaderf config
vim.g.Lf_UserCache = 0
vim.g.Lf_UseMemoryCache = 0
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "100"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

local opt = vim.opt
opt.number = true
