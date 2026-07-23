# Neovim Dev Config

一套面向日常开发的 Neovim 0.12 配置：启动轻、按需加载、语言支持完整，并兼容 VS Code Neovim。

原生 LSP · 智能补全 · 调试 · Git · 多光标 · AI Agent

![Neovim dashboard artwork](./assets/dashboard.png)

> [!NOTE]
> `<leader>` 和 `<localleader>` 均为分号键 `;`。按下 `;` 后，which-key 会展示当前可用操作。

## 为什么使用这套配置

- **保持启动轻量**：插件由 lazy.nvim 按事件、文件类型、命令或快捷键加载。
- **围绕项目工作**：搜索、文件树、终端和 Git 自动使用当前项目根目录。
- **开箱即用的开发链路**：LSP、补全、格式化、lint、调试和 Treesitter 已按语言组织。
- **AI 默认不打扰**：Copilot LSP 默认关闭；Codex、Claude、Gemini 等 CLI Agent 可独立按需打开。
- **双编辑器体验**：在 VS Code Neovim 中只加载通用选项与专用按键，不重复启动 UI、LSP 和补全。
- **安装结果可复现**：`lazy-lock.json` 固定已经验证过的插件版本。

## 界面与能力

空白启动会进入自定义首页。Warp Terminal 直接使用像素图片协议，其他终端在安装 `chafa` 后显示字符图片；不支持图片时自动回退到轻量文字首页。

| 领域 | 主要能力 |
| --- | --- |
| 导航 | Snacks Picker / Explorer、Oil、Flash、项目根目录识别 |
| 编辑 | Treesitter、自动配对、包围操作、多光标、跨项目搜索替换 |
| 代码智能 | Neovim 原生 LSP、blink.cmp、snippet、inlay hints、inline completion |
| 质量 | Conform 保存时格式化、nvim-lint、Trouble 诊断列表 |
| Git | Gitsigns、LazyGit、Diffview、文件历史与行级 blame |
| 调试 | nvim-dap、DAP UI、断点、REPL、Node / Python / Go / C / Rust |
| 工具 | HTTP Client、数据库 UI、浮动终端、scratch buffer |
| AI | Copilot LSP / Next Edit、Codex、Claude、Gemini 与其他 CLI Agent |

## 环境要求

### 必需

- Neovim `0.12+`
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- Node.js `20+` 与 npm
- 支持真彩色的终端
- Nerd Font 字体，用于文件类型和界面图标

### 按需安装

- `fd`：加速文件查找
- `lazygit`：Git TUI
- `chafa`：在非 Warp 终端显示启动页图片
- Go、Python、Rust、JDK 等对应语言工具链
- `docker`：容器相关工作流
- `codex`、`claude`、`gemini`：对应的 CLI Agent

可以随时执行 `:NvimDoctor` 查看本机依赖是否齐全。

## 安装

### 1. 备份现有配置

如果 `~/.config/nvim` 已存在，先将它移走：

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### 2. 克隆仓库

```bash
git clone https://github.com/dancvv/nvim_config.git ~/.config/nvim
```

### 3. 启动 Neovim

```bash
nvim
```

首次启动会自动安装 lazy.nvim、缺失插件以及声明的 Mason 工具。安装完成后建议依次执行：

```vim
:Lazy sync
:MasonToolsInstallSync
:TSInstallConfigured
:NvimHealth
```

## 快速上手

首页可直接使用以下单键：

| 按键 | 操作 |
| --- | --- |
| `f` | 查找文件 |
| `g` | 全局搜索 |
| `r` | 最近打开 |
| `n` | 新建文件 |
| `e` | 文件浏览 |
| `c` | 编辑配置 |
| `l` | 插件管理 |
| `q` | 退出 |

进入编辑区后，最常用的操作如下：

| 快捷键 | 操作 |
| --- | --- |
| `<leader><space>` | 项目智能搜索 |
| `<leader>ff` / `<leader>fg` | 查找文件 / 全文搜索 |
| `<leader>e` | 项目文件浏览器 |
| `<C-\>` | 打开项目终端 |
| `gd` / `gr` / `K` | 定义 / 引用 / 悬停文档 |
| `<leader>ca` / `<leader>rn` | Code Action / 重命名 |
| `<leader>fm` | 格式化 |
| `<leader>gg` | LazyGit |
| `<leader>gd` | Diffview |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | 继续 / 越过 / 进入 / 跳出调试 |
| `<leader>aa` | 打开或关闭 AI Agent |
| `<leader>aL` | 开启或关闭 Copilot LSP |

完整映射与多光标用法见 [KEYMAPS.md](./KEYMAPS.md)。

## 语言支持

| 语言 | LSP | 格式化 / lint | 调试 |
| --- | --- | --- | --- |
| TS / JS / Vue | vtsls、vue_ls、ESLint | Prettier、ESLint | js-debug |
| Python | BasedPyright、Ruff | Ruff | debugpy |
| Go | gopls | goimports、gofumpt | Delve |
| Rust | rust-analyzer | rustfmt | CodeLLDB |
| C / C++ | Clangd | clang-format | CodeLLDB |
| Java | jdtls | google-java-format | — |
| Lua | lua_ls、lazydev | Stylua | — |
| Shell | bash-language-server | shfmt、ShellCheck | — |
| HTML / CSS / JSON / YAML | 对应 LSP、SchemaStore、Emmet | Prettier | — |
| Docker / Terraform / TOML | dockerls、terraformls、Taplo | 原生工具 | — |
| SQL / Prisma | sqls、Prisma LS | sqlfluff | — |
| Markdown | Marksman | Prettier、markdownlint | — |

Mason 的可执行目录会在启动早期加入 `PATH`，Mason 本身仍保持懒加载。
Java 用户需要 JDK 21 运行最新版 jdtls；如本机 SDKMAN 路径不同，
请调整 `lua/plugins/lsp.lua` 中的 `jdtls_java_home`。

## AI：Copilot 与 CLI Agent

Copilot 使用 nvim-lspconfig 提供的原生 `copilot` 配置，并且默认关闭。
普通启动不会连接 Copilot；Codex、Claude、Gemini 等 CLI Agent 不受影响。

首次使用 Copilot：

```vim
:CopilotOn
:LspCopilotSignIn
```

常用操作：

| 快捷键或命令 | 操作 |
| --- | --- |
| `<leader>aL` | 开启或关闭 Copilot LSP |
| `<C-f>` | 接受 inline completion |
| `<leader>an` | 应用或跳转到 Copilot Next Edit |
| `<leader>aa` | 打开或关闭 Agent 终端 |
| `<leader>as` | 选择已安装的 Agent |
| `<leader>ac` / `<leader>aC` / `<leader>ag` | Codex / Claude / Gemini |
| `<C-.>` | 在编辑器与 Agent 终端之间切换焦点 |
| `:CopilotOff` | 关闭并立即停止 Copilot |

如果 Copilot 没有响应，可执行 `:checkhealth sidekick` 检查状态。

## VS Code Neovim

安装 [VSCode Neovim][vscode-neovim]，然后在 VS Code 用户设置中指定本配置：

```json
{
  "vscode-neovim.neovimInitVimPaths.darwin": "/Users/<用户名>/.config/nvim/init.lua"
}
```

仓库中的 [.vscode/settings.json](./.vscode/settings.json) 和
[.vscode/keybindings.json](./.vscode/keybindings.json) 可作为参考。
检测到 `vim.g.vscode` 后，配置只加载基础选项和
`lua/vscode_compat/keymaps.lua`。搜索、窗口、终端、Git、多光标与 AI 操作
交给 VS Code 原生命令。

## 配置结构

```text
.
├── init.lua                 # 入口：区分 Neovim 与 VS Code
├── lazy-lock.json           # 插件版本锁定
├── assets/
│   └── dashboard.png       # 首页图片
├── lua/
│   ├── config/
│   │   ├── init.lua        # 基础模块入口
│   │   ├── options.lua     # 编辑器选项
│   │   ├── keymaps.lua     # 通用快捷键
│   │   ├── autocmds.lua    # 自动命令
│   │   ├── commands.lua    # 自定义命令
│   │   ├── root.lua        # 项目根目录识别
│   │   └── lazy.lua        # lazy.nvim 启动与插件导入
│   ├── plugins/
│   │   ├── ui.lua          # 主题、首页、Picker、状态栏
│   │   ├── editor.lua      # 编辑与导航增强
│   │   ├── coding.lua      # Treesitter 与补全
│   │   ├── lsp.lua         # LSP、格式化、lint、Mason
│   │   ├── git.lua         # Git 集成
│   │   ├── dap.lua         # 调试
│   │   ├── ai.lua          # Copilot 与 CLI Agent
│   │   └── tools.lua       # HTTP 与数据库工具
│   └── vscode_compat/
│       └── keymaps.lua     # VS Code 专用映射
└── KEYMAPS.md              # 完整快捷键参考
```

## 维护与排查

| 命令 | 用途 |
| --- | --- |
| `:NvimDoctor` | 检查外部命令与工具链 |
| `:NvimHealth` | 检查插件、LSP、Treesitter、补全与格式化 |
| `:NvimRoot` | 显示当前项目根目录 |
| `:NvimConfig` | 快速打开本配置 |
| `:NvimUpdate` | 更新并清理插件 |
| `:MasonToolsInstallSync` | 同步安装声明的开发工具 |
| `:TSInstallConfigured` | 安装声明的 Treesitter parsers |

更新配置时建议保留 `lazy-lock.json`。它记录当前验证过的精确插件提交；主动升级后，再将新的锁文件与配置一同提交。

如果启动异常，可先运行：

```vim
:NvimDoctor
:NvimHealth
:Lazy
```

然后查看对应插件的日志或健康检查结果。

[vscode-neovim]: https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim
