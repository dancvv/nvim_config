# Modern Neovim Configuration

一个现代化、模块化的 Neovim 配置，提供 VSCode 级别的开发体验。

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## ✨ 特性

- 🚀 **快速启动**: 通过 lazy.nvim 实现插件懒加载
- 🎨 **美观界面**: Catppuccin 主题 + 现代化 UI 组件
- 💡 **智能补全**: LSP + nvim-cmp + Treesitter
- 🔍 **强大搜索**: Telescope 模糊查找
- 🌳 **文件管理**: Neo-tree 文件浏览器
- 🔧 **代码重构**: LSP 代码操作、重命名、格式化
- 📝 **语法高亮**: Treesitter 语法解析
- 🎯 **Git 集成**: Gitsigns + LazyGit + DiffView
- 🔨 **格式化**: conform.nvim 自动格式化
- 🐛 **代码检查**: nvim-lint + LSP diagnostics
- 📦 **会话管理**: 自动保存和恢复工作区
- 🎮 **VSCode 风格**: 熟悉的快捷键

## 📦 支持的语言

- TypeScript/JavaScript (ts_ls, eslint)
- Vue 3 (volar)
- React/JSX
- Go (gopls)
- Python (pyright)
- Lua (lua_ls)
- HTML/CSS/JSON/YAML
- Tailwind CSS

## 🚀 安装

### 前置要求

- Neovim >= 0.9.0
- Git
- [Nerd Font](https://www.nerdfonts.com/) (推荐 JetBrainsMono Nerd Font)
- Node.js (用于部分 LSP 服务器)
- [LazyGit](https://github.com/jesseduffield/lazygit) (可选，用于 Git UI)
- ripgrep (用于 Telescope 搜索)

### 快速开始

1. **备份现有配置**:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. **克隆或复制此配置**:
```bash
# 如果是全新配置
git clone <your-repo> ~/.config/nvim
# 或者直接使用当前配置
```

3. **启动 Neovim**:
```bash
nvim
```

首次启动时，lazy.nvim 会自动安装所有插件，Mason 会自动安装所有 LSP 服务器和工具。

4. **检查健康状态**:
```vim
:checkhealth
```

## 📖 文档

- **[KEYMAPS.md](KEYMAPS.md)** - 完整的快捷键参考
- **[CLAUDE.md](CLAUDE.md)** - 详细的配置说明和架构文档

## ⌨️ 核心快捷键

**Leader 键 = 分号 (;)**

### 常用操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 切换文件浏览器 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索 |
| `<leader>gg` | 打开 LazyGit |
| `<C-\>` | 切换终端 |

### LSP 功能

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `K` | 显示文档 |
| `<leader>ca` | 代码操作 |
| `<leader>rn` | 重命名 |
| `<leader>fm` | 格式化 |
| `[d` / `]d` | 上/下一个诊断 |

### Git 操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>gg` | LazyGit |
| `<leader>hs` | 暂存 hunk |
| `<leader>hp` | 预览 hunk |
| `]h` / `[h` | 下/上一个 hunk |

完整快捷键列表请参考 [KEYMAPS.md](KEYMAPS.md)

## 📁 目录结构

```
~/.config/nvim/
├── init.lua                    # 入口文件
├── README.md                   # 本文件
├── KEYMAPS.md                  # 快捷键文档
├── CLAUDE.md                   # 详细文档
└── lua/
    ├── core/                   # 核心配置
    │   ├── options.lua         # Vim 选项
    │   ├── keymaps.lua         # 快捷键
    │   └── autocmds.lua        # 自动命令
    ├── plugins/                # 插件配置
    │   ├── ui.lua              # UI 插件
    │   ├── editor.lua          # 编辑器增强
    │   ├── lsp.lua             # LSP 配置
    │   ├── coding.lua          # 代码补全
    │   ├── git.lua             # Git 集成
    │   └── tools.lua           # 工具插件
    └── lsp/                    # LSP 设置
        ├── setup.lua           # 服务器配置
        ├── handlers.lua        # LSP 处理器
        └── keymaps.lua         # LSP 快捷键
```

## 🎨 插件列表

### 核心插件

- **lazy.nvim** - 插件管理器
- **mason.nvim** - LSP/工具安装器
- **nvim-lspconfig** - LSP 配置
- **nvim-cmp** - 自动补全
- **nvim-treesitter** - 语法解析

### UI 插件

- **catppuccin** - 主题
- **lualine.nvim** - 状态栏
- **bufferline.nvim** - 标签栏
- **neo-tree.nvim** - 文件浏览器
- **alpha-nvim** - 启动页面
- **which-key.nvim** - 快捷键提示
- **nvim-notify** - 通知系统

### 编辑器增强

- **telescope.nvim** - 模糊查找
- **Comment.nvim** - 注释
- **nvim-autopairs** - 自动配对
- **nvim-surround** - 包围操作
- **trouble.nvim** - 诊断查看器
- **todo-comments.nvim** - TODO 注释

### Git 集成

- **gitsigns.nvim** - Git 状态显示
- **lazygit.nvim** - LazyGit 集成
- **diffview.nvim** - 差异查看
- **git-conflict.nvim** - 冲突解决

### 代码工具

- **conform.nvim** - 代码格式化
- **nvim-lint** - 代码检查
- **toggleterm.nvim** - 终端管理

## 🔧 自定义

### 添加新语言支持

1. 在 `lua/lsp/setup.lua` 中添加 LSP 服务器配置
2. 在 `lua/plugins/lsp.lua` 中添加到 Mason 安装列表
3. 在 `lua/plugins/lsp.lua` 中配置格式化器
4. 在 `lua/plugins/coding.lua` 中添加 Treesitter 解析器

详细步骤请参考 [CLAUDE.md](CLAUDE.md)

### 修改快捷键

- 全局快捷键: 编辑 `lua/core/keymaps.lua`
- LSP 快捷键: 编辑 `lua/lsp/keymaps.lua`

### 更换主题

编辑 `lua/plugins/ui.lua` 中的 colorscheme 插件配置。

## 🐛 故障排除

### LSP 不工作

```vim
:Mason          " 检查 LSP 服务器是否安装
:LspInfo        " 查看 LSP 状态
:LspLog         " 查看 LSP 日志
```

### 格式化不工作

```vim
:ConformInfo    " 查看格式化器配置
:Mason          " 检查格式化器是否安装
```

### 插件加载慢

```vim
:Lazy profile   " 查看插件加载时间
```

更多故障排除信息请参考 [CLAUDE.md](CLAUDE.md)

## 📚 学习资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📝 许可

MIT License

## 🙏 致谢

感谢所有插件作者和 Neovim 社区的贡献！
