# 快捷键

`<leader>` 是分号键 `;`。按下 `;` 后，which-key 会显示当前可用分组。

空白启动进入首页后，可直接按 `f` 查文件、`g` 搜正文、`r` 看最近文件、`n` 新建、`e` 浏览目录、`c` 编辑配置、`l` 管理插件、`q` 退出。

## 通用与窗口

| 快捷键 | 功能 |
| --- | --- |
| `<C-s>` | 保存 |
| `jk` | 退出 Insert 模式 |
| `<leader>q` / `<leader>Q` | 退出窗口 / 强制退出全部 |
| `H` / `L` | 跳到当前行行首 / 行尾 |
| `<C-j>` / `<C-k>` | 向下 / 向上移动 5 行并居中 |
| `<C-h>` / `<C-l>` | 切换左 / 右窗口 |
| `<leader>wj` / `<leader>wk` | 切换下 / 上窗口 |
| `<leader>wv` / `<leader>wh` | 垂直 / 水平分屏 |
| `<leader>wq` / `<leader>wo` | 关闭窗口 / 仅保留当前窗口 |
| `[b` / `]b` | 上一个 / 下一个 buffer |
| `<leader>bb` / `<leader>bn` / `<leader>bd` | 上一个 / 新建 / 删除 buffer |
| `<A-j>` / `<A-k>` | 向下 / 向上移动行或选区 |
| `<C-a>` | 全选 |
| `<leader>ul` / `<leader>uL` | 切换行号 / 相对行号 |
| `<leader>uw` / `<leader>us` / `<leader>ud` | 切换换行 / 拼写 / 诊断 |

## 文件、搜索与终端

| 快捷键 | 功能 |
| --- | --- |
| `<leader><space>` | 项目智能搜索 |
| `<leader>ff` / `<leader>fF` | 从项目根 / 当前目录查文件 |
| `<leader>fg` / `<leader>fG` | 从项目根 / 当前目录全文搜索 |
| `<leader>fb` / `<leader>fr` / `<leader>fR` | Buffer / 项目最近文件 / 全局最近文件 |
| `<leader>fc` / `<leader>fp` | 搜索当前词 / 项目列表 |
| `<leader>fh` / `<leader>fk` | 帮助 / 快捷键搜索 |
| `<leader>e` / `<leader>E` | 项目 Explorer / 当前文件目录 |
| `<leader>-` | Oil 父目录编辑器 |
| `<leader>sr` / `<leader>sw` | 搜索替换 / 替换当前词 |
| `s` / `S` | Flash 跳转 / Treesitter 跳转 |
| `<C-\>` / `<leader>tt` | 项目终端 |
| `<Esc><Esc>` | 终端回到 Normal 模式 |

## 多光标

只想不断向下加光标时，重复按 `<C-Down>` 或 `<leader>mj`。

| 快捷键 | 功能 |
| --- | --- |
| `<C-Down>` / `<leader>mj` | 在下一行添加光标 |
| `<leader>mk` | 在上一行添加光标 |
| `<C-n>` / `<leader>mn` | 添加下一个匹配 |
| `<leader>mN` | 添加上一个匹配 |
| `<leader>ma` | 添加全部匹配 |
| `<leader>ms` | 跳过下一个匹配 |
| `<leader>mt` | 切换当前位置的光标 |
| `<leader>mr` | 恢复上次光标 |
| `<leader>m=` | 对齐光标 |
| `<C-LeftMouse>` | 鼠标添加或移除光标 |
| `<Esc>` | 清空多光标 |

VS Code 模式下相同的向下、多匹配和全匹配按键会调用 VS Code 原生多光标命令。

## LSP、补全与格式化

| 快捷键 | 功能 |
| --- | --- |
| `gd` / `gD` | 定义 / 声明 |
| `gi` / `gr` / `gy` | 实现 / 引用 / 类型定义 |
| `K` / Insert `<C-k>` | 悬停文档 / 签名帮助 |
| `<leader>ca` / `<leader>rn` | Code action / 重命名 |
| `<leader>co` / `<leader>cF` | 整理 imports / Fix all |
| `[d` / `]d` | 上一个 / 下一个诊断 |
| `<leader>df` / `<leader>dl` | 行诊断 / 诊断列表 |
| `<leader>ds` / `<leader>ws` | 文档 / 工作区符号 |
| `<leader>uh` | 切换 inlay hints |
| `<leader>fm` / `<leader>uf` | 手动格式化 / 切换保存时格式化 |
| Insert `<C-f>` / `<C-g>` | 接受 / 切换 inline completion |
| `<leader>cm` | Mason |
| `<leader>cI` / `<leader>cU` | 安装 / 更新开发工具 |

## AI

| 快捷键 | 功能 |
| --- | --- |
| `<leader>aa` | 打开或关闭 Agent |
| `<leader>as` / `<leader>ad` | 选择 Agent / 关闭 Agent 会话 |
| `<leader>ac` / `<leader>aC` / `<leader>ag` | Codex / Claude / Gemini |
| `<leader>aL` | 开启或关闭 Copilot LSP，默认关闭 |
| `<leader>at` / `<leader>af` / Visual `<leader>av` | 发送上下文 / 文件 / 选区 |
| `<leader>ap` | Agent prompt 库 |
| `<leader>an` / `<leader>au` / `<leader>aT` | 应用 / 请求 / 切换 Copilot Next Edit |
| `<C-.>` | 聚焦 Agent |

VS Code 模式使用 `<leader>aa` 打开 Chat、`<leader>aA` 打开 Agent、`<leader>ai` 打开 Inline Chat。

## Git 与调试

| 快捷键 | 功能 |
| --- | --- |
| `<leader>gg` | LazyGit |
| `<leader>gs` / `<leader>gl` / `<leader>gL` | 状态 / 仓库日志 / 文件日志 |
| `<leader>gb` / `<leader>go` | 分支 / 打开 Git URL |
| `<leader>gd` / `<leader>gh` | Diffview / 文件历史 |
| `]h` / `[h` | 下一个 / 上一个 hunk |
| `<leader>hs` / `<leader>hr` | 暂存 / 重置 hunk |
| `<leader>hS` / `<leader>hR` | 暂存 / 重置文件 |
| `<leader>hp` / `<leader>hb` | 预览 hunk / 当前行 blame |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | 继续 / 单步越过 / 进入 / 跳出 |
| `<leader>db` / `<leader>dB` | 断点 / 条件断点 |
| `<leader>dc` / `<leader>dl` | 继续 / 重跑上次调试 |
| `<leader>dr` / `<leader>dq` / `<leader>du` | REPL / 结束 / 调试 UI |

## 工具与命令

| 快捷键或命令 | 功能 |
| --- | --- |
| `<leader>rr` / `<leader>ra` | 运行当前 / 全部 HTTP 请求 |
| `<leader>ri` / `<leader>rs` | 检查请求 / HTTP scratchpad |
| `<leader>DD` / `<leader>Da` | 数据库 UI / 添加连接 |
| `<leader>xx` / `<leader>xX` | 当前 buffer / 工作区诊断 |
| `<leader>xL` / `<leader>xQ` | Location / Quickfix 列表 |
| `:NvimRoot` / `:NvimConfig` | 显示项目根 / 打开配置 |
| `:NvimDoctor` / `:NvimHealth` | 检查外部依赖 / 核心健康 |
| `:NvimUpdate` | 更新并清理插件 |
| `:CopilotOn` / `:CopilotOff` | 开启 / 关闭 Copilot LSP |
| `:TSInstallConfigured` | 安装配置声明的 Treesitter parsers |
