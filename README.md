# Neovim 开发配置

这是一套面向 Neovim 0.12 的轻量开发配置。核心原则是空白启动快、打开代码后按需加载、Neovim 与 VS Code 共用一套基础按键，并通过锁文件固定已经验证过的插件版本。

`<leader>` 是分号键 `;`。

## 能力

- 首页：空白启动时展示山景欢迎页、常用入口和最近文件；Warp 中使用像素图片协议清晰渲染，其他终端由 `chafa` 兼容显示，缺失时自动使用轻量文字首页。
- 编辑：Treesitter、项目搜索、文件浏览、终端、Git、Diffview、多光标、结构化跳转、搜索替换。
- 语言：TypeScript / JavaScript / Vue、Python、Go、Rust、C / C++、Java、Lua、Shell、HTML / CSS、JSON / YAML、Docker、Terraform / HCL、SQL、Prisma、Markdown。
- 代码智能：Neovim 原生 LSP、blink.cmp、snippet、inlay hints、诊断、保存时格式化和 lint。
- 调试：Node / TypeScript、Python、Go、Rust、C / C++，并自动读取项目的 `.vscode/launch.json`。
- AI：按需启用的 GitHub Copilot Language Server、原生 inline completion、Copilot Next Edit Suggestions，以及 Codex、Claude、Gemini、OpenCode 等 CLI Agent。
- VS Code：检测到 `vim.g.vscode` 后只加载通用设置和 VS Code 专用映射，不启动 Neovim 的 UI、LSP 或补全插件。

## 环境要求

- Neovim 0.11.2 以上，推荐当前稳定版。
- `git`、`rg`、`fd`、Node.js 20+ 和 npm。
- 对应语言的本机工具链，例如 Go、Rust、Java、Python。
- 最新版 JDTLS 运行时需要 JDK 21；项目本身仍可使用自己的 Java toolchain。
- 可选：`lazygit`、`docker`、`codex`、`claude`、`gemini`、`chafa`（启动页图片）。

首次启动会自动安装缺失插件。完整初始化可执行：

```vim
:Lazy sync
:MasonToolsInstallSync
:TSInstallConfigured
```

检查环境和配置：

```vim
:NvimDoctor
:NvimHealth
```

## 语言支持

| 语言 | LSP | 格式化 / lint | 调试 |
| --- | --- | --- | --- |
| TypeScript / JavaScript / Vue | vtsls、vue_ls、eslint、Tailwind、Emmet | Prettierd / Prettier、ESLint | js-debug |
| Python | BasedPyright、Ruff | Ruff | debugpy |
| Go | gopls | goimports、gofumpt | Delve |
| Rust | rust-analyzer | rustfmt | CodeLLDB |
| C / C++ | Clangd | clang-format | CodeLLDB |
| Java | jdtls | google-java-format | 项目 `launch.json` |
| Lua | lua_ls、lazydev | Stylua | — |
| Shell | bash-language-server | shfmt、ShellCheck | — |
| Web / 配置 | HTML、CSS、JSON、YAML、Docker、Terraform、Taplo | Prettier、Hadolint、terraform-ls、Taplo | — |
| SQL / Prisma | sqls、Prisma LS | sqlfluff（项目需声明 dialect） | — |

Mason 的可执行目录会在启动早期加入 Neovim 的 PATH，但 Mason 本身仍保持懒加载。

## GitHub Copilot 与 Agent

Copilot 使用 `nvim-lspconfig` 自带的官方 `copilot` 配置，不依赖旧式 Vimscript 插件。它默认关闭，因此普通启动不会访问 macOS 钥匙串；Codex、Claude、Gemini 等 CLI Agent 不受影响。

需要 Copilot 时按 `<leader>aL`，或执行：

```vim
:CopilotOn
```

关闭并立即停止 Copilot：

```vim
:CopilotOff
```

首次开启后如需登录：

```vim
:LspCopilotSignIn
```

常用操作：

- `<Tab>`：依次尝试 snippet、Copilot Next Edit、原生 inline completion，最后回退到普通 Tab。
- `<C-f>`：接受原生 inline completion。
- `<leader>an`：应用或跳转到 Copilot Next Edit。
- `<leader>aL`：按需开启或关闭 Copilot LSP。
- `<leader>aa`：打开 Agent 终端。
- `<leader>as`：选择本机已安装的 Agent。
- `<leader>ac` / `<leader>aC` / `<leader>ag`：打开 Codex / Claude / Gemini。
- `<C-.>`：在编辑器和 Agent 终端间切换焦点。

可用性检查：

```vim
:CopilotOn
:checkhealth sidekick
```

## VS Code

安装 `asvetliakov.vscode-neovim`，并在 VS Code 的用户设置中让扩展读取本配置：

```json
{
  "vscode-neovim.neovimInitVimPaths.darwin": "/Users/wangwei69/.config/nvim/init.lua"
}
```

仓库内的 `.vscode/settings.json` 和 `.vscode/keybindings.json` 可作为设置与快捷键参考。VS Code 模式复用 LSP 跳转、搜索、窗口、终端、Git、多光标和 Copilot Chat 操作；其中 `<C-Down>` 或 `<leader>mj` 会持续向下添加光标。

## 更新策略

`lazy-lock.json` 记录本次验证过的精确插件提交，保证重装可复现。需要更新时依次执行：

```vim
:NvimUpdate
:MasonToolsUpdateSync
:TSUpdate
```

更新后建议再次运行 `:NvimHealth`。完整快捷键见 [KEYMAPS.md](./KEYMAPS.md)。
