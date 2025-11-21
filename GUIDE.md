# Neovim 配置使用指南

这是一个针对 Vue3、React、Go、Python 开发优化的 Neovim 配置,提供类似 VSCode 的开发体验。

## 主要特性

### 语言支持
- **前端开发**: Vue3, React, JavaScript, TypeScript, HTML, CSS, SCSS
- **后端开发**: Go, Python
- **配置文件**: JSON, YAML, TOML, Markdown
- 完整的语法高亮和智能提示
- 自动格式化和代码检查

### 核心功能
- LSP (Language Server Protocol) 支持
- 智能代码补全(nvim-cmp + Copilot)
- 代码片段(LuaSnip)
- 语法高亮(Treesitter)
- 模糊搜索(Telescope)
- Git 集成(Gitsigns)
- 文件浏览器(nvim-tree, mini.files)
- 符号大纲视图
- 代码折叠
- 多光标编辑

## 安装步骤

### 1. 首次启动

```bash
nvim
```

首次启动时,Lazy.nvim 会自动下载并安装所有插件。

### 2. 安装 LSP 服务器和工具

在 Neovim 中运行:

```vim
:MasonInstallAll
```

或者手动打开 Mason 选择安装:

```vim
:Mason
```

推荐安装的工具:
- **LSP**: html, cssls, ts_ls, volar, eslint, pyright, gopls, lua_ls, jsonls, yamlls, tailwindcss
- **格式化**: prettierd, prettier, stylua, black, isort, gofumpt, goimports
- **检查**: eslint_d, stylelint

### 3. 安装 Treesitter 解析器

```vim
:TSUpdate
```

## 主要快捷键

### 通用操作
- `<Leader>` = `Space`
- `<Leader>e` - 打开/关闭文件浏览器
- `<Leader>ff` - 查找文件
- `<Leader>fl` - 在文件中搜索文本
- `<Leader>fb` - 查看打开的缓冲区
- `<Leader>fp` - 切换项目

### LSP 功能
- `gd` - 跳转到定义
- `gr` - 查看引用
- `gi` - 跳转到实现
- `K` - 显示悬停文档
- `<Leader>ca` - 代码操作
- `<Leader>rn` - 重命名符号
- `[d` / `]d` - 上一个/下一个诊断
- `<Leader>df` - 文档诊断列表
- `<Leader>ds` - 文档符号
- `<Leader>so` - 符号大纲

### 编辑功能
- `<Ctrl-/>` - 注释/取消注释
- `<Leader>mp` - 格式化当前文件
- `s` + 两个字符 - 快速跳转(Hop)
- `<Ctrl-d>` - 选择下一个相同单词(多光标)
- `Tab` / `Shift-Tab` - 在补全菜单中导航

### Git 操作
- `]c` / `[c` - 下一个/上一个 Git hunk
- `<Leader>hp` - 预览 hunk
- `<Leader>hs` - 暂存 hunk
- `<Leader>hr` - 重置 hunk
- `<Leader>hb` - 查看 blame

### 窗口和缓冲区
- `[b` / `]b` - 上一个/下一个缓冲区
- `<Leader>q` - 关闭当前缓冲区
- `<Leader>bd` - 删除缓冲区
- `<Ctrl-\>` - 打开终端

### 搜索和替换
- `<Leader>sr` - 全局搜索和替换
- `<Leader>sw` - 搜索当前单词

## 自动功能

- ✅ 保存时自动格式化
- ✅ 自动保存
- ✅ 自动补全
- ✅ 高亮相同单词
- ✅ Git 状态显示
- ✅ 诊断虚拟文本
- ✅ 持久撤销历史

## 文件类型特定配置

### Vue 3
- Volar LSP 提供完整的 Vue 3 支持
- 包括 `<script setup>` 语法
- 自动标签补全
- 组件属性提示

### React/JSX
- TypeScript LSP 支持 JSX/TSX
- ESLint 集成
- 自动导入

### Go
- gopls 提供完整的 Go 语言支持
- goimports 自动导入管理
- gofumpt 格式化

### Python
- Pyright 类型检查
- Black 格式化
- isort 导入排序

## 插件列表

### 核心插件
- **lazy.nvim** - 插件管理器
- **nvim-lspconfig** - LSP 配置
- **mason.nvim** - LSP/工具安装器
- **nvim-cmp** - 自动补全
- **nvim-treesitter** - 语法高亮

### 增强插件
- **telescope.nvim** - 模糊搜索
- **gitsigns.nvim** - Git 集成
- **nvim-tree.lua** - 文件浏览器
- **lualine.nvim** - 状态栏
- **barbar.nvim** - 标签栏
- **copilot.lua** - GitHub Copilot
- **hop.nvim** - 快速跳转
- **vim-visual-multi** - 多光标
- **trouble.nvim** - 诊断列表
- **symbols-outline.nvim** - 符号大纲
- **lspsaga.nvim** - 增强 LSP UI

## 主题

当前使用 Catppuccin 主题。可以通过修改 `lua/plugins/colorschemes.lua` 更改主题。

## 自定义配置

### 目录结构
```
~/.config/nvim/
├── init.lua                      # 入口文件
├── lua/
│   ├── core/                     # 核心配置
│   │   ├── init.lua
│   │   ├── options.lua           # Vim 选项
│   │   ├── keybindings.lua       # 快捷键
│   │   └── lazy.lua              # 插件管理器
│   ├── lsp/                      # LSP 配置
│   │   ├── init.lua
│   │   └── handlers.lua          # LSP 处理器
│   ├── plugins/                  # 插件配置
│   │   ├── lsp.lua               # LSP 插件
│   │   ├── editor.lua            # 编辑器插件
│   │   ├── ui.lua                # UI 插件
│   │   ├── autocomplete.lua      # 自动补全
│   │   ├── git.lua               # Git 插件
│   │   ├── enhancements.lua      # 增强功能
│   │   └── configs/              # 具体插件配置
│   └── ui/                       # UI 相关
```

### 修改配置

1. **修改快捷键**: 编辑 `lua/core/keybindings.lua` 或各插件配置文件中的 `keys` 部分
2. **添加 LSP 服务器**: 编辑 `lua/plugins/configs/lspconfig.lua`
3. **添加格式化器**: 编辑 `lua/plugins/editor.lua` 中的 `conform.nvim` 配置
4. **修改主题**: 编辑 `lua/plugins/colorschemes.lua`

## 常见问题

### 1. LSP 不工作
确保已安装相应的 LSP 服务器:
```vim
:Mason
```

### 2. 格式化不工作
确保已安装格式化工具并检查配置:
```vim
:ConformInfo
```

### 3. 补全不出现
检查 LSP 是否运行:
```vim
:LspInfo
```

### 4. 插件加载慢
查看插件加载时间:
```vim
:Lazy profile
```

## 性能优化

- 使用 lazy loading 加载插件
- 优化 Treesitter 解析器数量
- 调整 `updatetime` 和 `timeoutlen`
- 禁用不需要的语言服务器

## 更新配置

拉取最新配置后,在 Neovim 中运行:
```vim
:Lazy sync
:TSUpdate
:MasonUpdate
```

## 资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
