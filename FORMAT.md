# 代码格式化配置

## 当前状态

**自动格式化**: ❌ 已禁用

代码**不会**在保存时自动格式化。需要手动触发格式化。

## 手动格式化

### 快捷键

- **`;fm`** (leader + fm) - 格式化当前文件

### 命令

```vim
:lua require("conform").format({ async = true, lsp_fallback = true })
```

## 支持的语言和格式化工具

| 语言               | 格式化工具            |
| ------------------ | --------------------- |
| Lua                | stylua                |
| Python             | isort + black         |
| JavaScript/TS      | prettierd or prettier |
| React (JSX/TSX)    | prettierd or prettier |
| Vue                | prettierd or prettier |
| CSS/SCSS           | prettierd or prettier |
| HTML               | prettierd or prettier |
| JSON/YAML/Markdown | prettierd or prettier |
| Go                 | goimports + gofumpt   |

## 如何启用自动格式化

如果你想要启用保存时自动格式化，编辑 `lua/plugins/lsp.lua` 文件：

找到这部分（约第 126 行）：

```lua
-- Disable format on save - use <leader>fm to format manually
-- format_on_save = {
--   timeout_ms = 500,
--   lsp_fallback = true,
-- },
```

取消注释：

```lua
-- Auto-format on save
format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true,
},
```

然后重启 Neovim 或运行 `:source ~/.config/nvim/init.lua`

## 如何禁用自动格式化

将上述配置重新注释掉即可：

```lua
-- format_on_save = {
--   timeout_ms = 500,
--   lsp_fallback = true,
-- },
```

## 检查格式化工具状态

```vim
:ConformInfo
```

这会显示：

- 当前文件类型的可用格式化工具
- 工具是否已安装
- 格式化配置状态

## 安装格式化工具

所有格式化工具通过 Mason 自动安装。如果缺少工具：

```vim
:Mason
```

搜索并安装所需的格式化工具。
