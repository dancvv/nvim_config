# Cmdline 配置指南

noice.nvim 的 cmdline 配置详解，位于 `lua/plugins/ui.lua`

## ⚠️ 光标跳转问题修复

**问题**: 使用 `view = "cmdline_popup"` 时，输入字符后光标会跳到第一个位置。

**解决方案**: 使用 `view = "cmdline"` (底部命令行)，而不是 `cmdline_popup` (浮动弹窗)。

```lua
cmdline = {
  enabled = true,
  view = 'cmdline',  -- 使用底部命令行，光标正常跟随输入
}
```

**当前配置已采用此修复** ✅

---

## 配置位置

在 `lua/plugins/ui.lua` 的 noice.nvim 插件配置中：

```lua
opts = {
  cmdline = { ... },
  views = {
    cmdline_popup = { ... },
  },
}
```

---

## 1. 基础配置 (cmdline)

### 启用/禁用

```lua
cmdline = {
  enabled = true,  -- 启用 noice cmdline（false 则使用原生命令行）
  view = "cmdline_popup",  -- 视图类型
}
```

**view 选项**：
- `"cmdline_popup"` - 浮动弹窗（居中显示）**[当前使用]**
- `"cmdline"` - 底部命令行（类似原生）

### 图标和格式 (format)

```lua
format = {
  -- Vim 命令 (:w, :q 等)
  cmdline = {
    pattern = "^:",      -- 匹配以 : 开头
    icon = ":",          -- 显示的图标
    lang = "vim"         -- 语法高亮语言
  },

  -- 向下搜索 /
  search_down = {
    kind = "search",
    pattern = "^/",
    icon = "/",          -- 可改为 " " 等
    lang = "regex"
  },

  -- 向上搜索 ?
  search_up = {
    kind = "search",
    pattern = "^%?",
    icon = "?",
    lang = "regex"
  },

  -- Shell 命令 :!
  filter = {
    pattern = "^:%s*!",
    icon = "!",          -- 可改为 "$"
    lang = "bash"
  },

  -- Lua 命令 :lua
  lua = {
    pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
    icon = "=",          -- 可改为 ""
    lang = "lua"
  },

  -- 帮助命令 :help
  help = {
    pattern = "^:%s*he?l?p?%s+",
    icon = "?"
  },

  -- 输入框
  input = {},
}
```

**图标示例**：
```lua
-- 极简风格（当前）
icon = ":"

-- Nerd Font 图标
icon = ""  -- 命令图标
icon = ""  -- 搜索图标
icon = ""  -- 终端图标
```

---

## 2. 视图配置 (views.cmdline_popup)

### 位置 (position)

```lua
position = {
  row = "50%",   -- 垂直位置
  col = "50%",   -- 水平位置
}
```

**选项**：
```lua
-- 居中（当前）
row = "50%", col = "50%"

-- 顶部居中
row = 5, col = "50%"

-- 底部（类似原生）
row = -2, col = 0

-- 右上角
row = 1, col = "100%"
```

### 大小 (size)

```lua
size = {
  min_width = 60,    -- 最小宽度
  width = "auto",    -- 自动宽度
  height = "auto",   -- 自动高度
}
```

**选项**：
```lua
-- 固定宽度
width = 80

-- 占屏幕百分比
width = "80%"

-- 根据内容自动（当前）
width = "auto"
```

### 边框 (border)

```lua
border = {
  style = "single",   -- 边框样式
  padding = { 0, 1 }, -- 内边距 [上下, 左右]
}
```

**style 选项**：
```lua
style = "none"      -- 无边框
style = "single"    -- 单线 ─│ （当前）
style = "double"    -- 双线 ═║
style = "rounded"   -- 圆角 ╭╮╰╯
style = "solid"     -- 实心
style = "shadow"    -- 带阴影

-- 自定义边框字符
style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
```

### 窗口选项 (win_options)

```lua
win_options = {
  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  cursorline = false,    -- 禁用行高亮
  cursorcolumn = false,  -- 禁用列高亮
}
```

**winhighlight 选项**：
```lua
-- 使用普通背景（当前）
winhighlight = "Normal:Normal,FloatBorder:FloatBorder"

-- 使用特殊背景
winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"

-- 带颜色边框
winhighlight = "Normal:Normal,FloatBorder:DiagnosticInfo"

-- 透明背景
winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"
```

---

## 3. 补全菜单 (views.popupmenu)

```lua
popupmenu = {
  backend = "nui",
  relative = "editor",
  position = {
    row = "auto",      -- 自动跟随 cmdline
    col = "50%",
  },
  size = {
    width = 60,
    height = "auto",
    max_height = 15,   -- 最大高度
  },
  border = {
    style = "single",
    padding = { 0, 1 },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    cursorline = true,     -- 启用行高亮（选择项）
    cursorcolumn = false,
  },
}
```

---

## 4. 预设 (presets)

```lua
presets = {
  bottom_search = false,         -- false: 现代搜索 UI（浮窗）
  command_palette = true,        -- cmdline 和 popupmenu 一起显示
  long_message_to_split = true,  -- 长消息在 split 中显示
  inc_rename = false,            -- inc-rename 集成
  lsp_doc_border = true,         -- LSP 文档带边框
}
```

---

## 5. 常见配置方案

### 方案 1: 极简居中（当前配置）

```lua
cmdline = {
  enabled = true,
  view = "cmdline_popup",
  format = {
    cmdline = { pattern = "^:", icon = ":", lang = "vim" },
  },
}

views = {
  cmdline_popup = {
    position = { row = "50%", col = "50%" },
    size = { min_width = 60, width = "auto", height = "auto" },
    border = { style = "single", padding = { 0, 1 } },
  }
}
```

### 方案 2: 传统底部

```lua
cmdline = {
  enabled = true,
  view = "cmdline",  -- 改用底部
}

presets = {
  bottom_search = true,  -- 底部搜索
}
```

### 方案 3: VSCode 风格

```lua
cmdline = {
  enabled = true,
  view = "cmdline_popup",
  format = {
    cmdline = { pattern = "^:", icon = ">", lang = "vim" },
    search_down = { pattern = "^/", icon = "", lang = "regex" },
  },
}

views = {
  cmdline_popup = {
    position = { row = 5, col = "50%" },  -- 顶部居中
    size = { width = 80, height = "auto" },
    border = { style = "rounded", padding = { 0, 2 } },
  }
}
```

### 方案 4: 无边框透明

```lua
views = {
  cmdline_popup = {
    position = { row = "50%", col = "50%" },
    size = { width = "auto", height = "auto" },
    border = { style = "none" },  -- 无边框
    win_options = {
      winhighlight = "Normal:NormalFloat",
      winblend = 10,  -- 半透明
    },
  }
}
```

### 方案 5: 右下角小窗口

```lua
views = {
  cmdline_popup = {
    position = { row = -3, col = "100%" },  -- 右下角
    size = { width = 40, height = "auto" },
    border = { style = "rounded" },
  }
}
```

---

## 6. 禁用 Noice Cmdline

如果想禁用 noice 的 cmdline，使用原生命令行：

```lua
{
  "folke/noice.nvim",
  opts = {
    cmdline = {
      enabled = false,  -- 禁用
    },
  }
}
```

或者完全禁用 noice.nvim：

```lua
-- 在 lua/plugins/ui.lua 中注释掉整个 noice.nvim 配置
-- {
--   "folke/noice.nvim",
--   ...
-- },
```

---

## 7. 实时预览修改

修改配置后：

```vim
:Lazy reload noice.nvim
:Noice
```

或直接重启 Neovim：

```bash
nvim
```

---

## 8. 调试和查看

```vim
:Noice             " 打开 noice 面板
:Noice history     " 查看消息历史
:Noice stats       " 查看统计
:Noice telescope   " 用 telescope 搜索消息
```

---

## 当前配置总结

**位置**: 居中浮窗
**边框**: 单线 `─│`
**图标**: 简单符号 `:`, `/`, `?`, `!`, `=`
**背景**: 与编辑器一致
**光标**: 不闪烁
**补全**: 自动跟随在 cmdline 下方

修改配置文件位置：`~/.config/nvim/lua/plugins/ui.lua`
