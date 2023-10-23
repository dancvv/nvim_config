vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- vim.g.camelcasemotion_key = "<leader>"
-- setting the local variable
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {noremap = true, silent = true }
-- setting mapping variable

-- map("n", "<leader>q", ":q<CR>", opt)
-- jump to head or last
map("", "H", "^", opt)
map("", "L", "$", opt)
-- 取消 key 的默认功能
-- map("n", "s", "", opt)

-- windows 分屏快捷键
map("n", "<leader>v", ":vsp<CR>", opt)
map("n", "<leader>h", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>c", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>o", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- macos setting
map("n", "˙", "<C-w>h", opt)
map("n", "∆", "<C-w>j", opt)
map("n", "˚", "<C-w>k", opt)
map("n", "¬", "<C-w>l", opt)

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "<leader>,", ":vertical resize -20<CR>", opt)
map("n", "<leader>.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "<leader>j", ":resize +10<CR>", opt)
map("n", "<leader>k", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "<leader>=", "<C-w>=", opt)
-- 退出快捷键
map("i", "jk", "<ESC>", opt)

-- bufferline key mapping
-- 左右Tab切换
map("n", "E", ":BufferLineCyclePrev<CR>", opt)
map("n", "R", ":BufferLineCycleNext<CR>", opt)
-- close buffer
map("n", "<leader>q", ":Bdelete<CR>", opt)

-- nvim tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "µ", ":NvimTreeToggle<CR>", opt)
