vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- vim.g.camelcasemotion_key = "<leader>"
-- setting the local variable
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {noremap = true, silent = true }
-- setting mapping variable
local gmap = vim.keymap.set


-- close local window
-- map("n", "<leader>q", ":q<CR>", opt)
-- jump to head or last
map("", "H", "^", opt)
map("", "L", "$", opt)
-- 取消 key 的默认功能
-- map("n", "s", "", opt)

-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
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

-- vscode config
if vim.g.vscode then
-- Folding
  gmap("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
  gmap("n", "zc", function() vim.fn.VSCodeNotify("editor.foldRecursively") end)
  gmap("n", "zC", function() vim.fn.VSCodeNotify("editor.foldAll") end)
  gmap("n", "zO", function() vim.fn.VSCodeNotify("editor.unfoldAll") end)
  gmap("n", "zo", function() vim.fn.VSCodeNotify("editor.unfoldRecursively") end)
  gmap("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold") end)

  -- All remaps
  gmap("", "zy", function() vim.fn.VSCodeNotify("toggleTypewriter") end)

  -- Normal remaps
  gmap("n", "[f", function() vim.fn.VSCodeNotify("workbench.view.search.focus") end)
  gmap("n", "]f", function() vim.fn.VSCodeNotify("workbench.action.replaceInFiles") end)
  gmap("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
  gmap("n", ";s", function() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end)
  gmap("n", "=<", function() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end)
  gmap("n", "gl", function() vim.fn.VSCodeNotify("editor.action.openLink") end)
  gmap("n", "<C-k>", function()
    vim.fn.VSCodeCall("editor.action.insertLineBefore")
    vim.cmd("norm k")
  end)
  gmap("n", "<<", function() vim.fn.VSCodeNotify("editor.action.outdentLines") end)
  gmap("n", ">>", function() vim.fn.VSCodeNotify("editor.action.indentLines") end)

  -- Visual remaps
  gmap("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)
  gmap("v", "<", function() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end)
  gmap("v", ">", function() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end)

  -- Insert remaps
  gmap("i", "<C-k>", function() vim.fn.VSCodeNotify("editor.action.insertLineBefore") end)
  -- Move editor
  gmap("n", ";h", function() vim.fn.VSCodeNotify("workbench.action.moveEditorToPreviousGroup") end)
  gmap("n", ";l", function() vim.fn.VSCodeNotify("workbench.action.moveEditorToNextGroup") end)

--vim.api.nvim_set_keymap("n", "<leader>q", "<Cmd>call", {"VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>"})
-- vim.cmd([[noremap sv :vsp<CR>]])
--gmap("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
gmap("n", ";q", function() vim.fn.VSCodeNotify("workbench.action.closeActiveEditor") end)
-- gmap("n", "E", "gT")
gmap("n", ";v", function() vim.fn.VSCodeNotify("workbench.action.splitEditor") end)
  gmap("n", ";b", function() vim.fn.VSCodeCall("workbench.action.toggleSidebarVisibility", true) end)
  gmap("n", ";e", function() vim.fn.VSCodeCall("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup", true) end)
  gmap("n", ";r", function() vim.fn.VSCodeCall("workbench.action.openNextRecentlyUsedEditorInGroup", true) end)
end
-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s.", ":vertical resize +20<CR>", opt)
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)
-- 退出快捷键
map("i", "jk", "<ESC>", opt)

-- bufferline key mapping
-- 左右Tab切换
map("n", "E", ":BufferLineCyclePrev<CR>", opt)
map("n", "R", ":BufferLineCycleNext<CR>", opt)
-- close buffer
map("n", "<leader>q", ":Bdelete<CR>", opt)

-- export the key mapping for the tree
-- -- 插件快捷键
local pluginKeys = {}

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "µ", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}
-- telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    return {
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- 取消
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        -- tab select
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          -- elseif has_words_before() then
            -- cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),
        -- super tab
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
    }
end

-- visual multi cursor
-- map("n", "mn", "<C-n>", opt)
-- let g:VM_leader = ';'
-- let g:VM_maps = {}
-- let g:VM_maps['Find Under'] = '<leader>n'

return pluginKeys

