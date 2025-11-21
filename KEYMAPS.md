# Neovim 配置快捷键参考

## 说明
- `<leader>` = 分号键 (`;`)
- `<C-x>` = Ctrl + x
- `<A-x>` = Alt/Option + x
- `<S-x>` = Shift + x

## 通用操作

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `jk` / `kj` | Insert | 退出插入模式 |
| `<C-s>` | Normal/Insert | 保存文件 |
| `<leader>q` | Normal | 退出 |
| `<leader>Q` | Normal | 强制退出所有 |
| `<ESC>` | Normal | 清除搜索高亮 |

## 导航

### 窗口导航
| 快捷键 | 功能 |
|--------|------|
| `<C-h>` | 移动到左侧窗口 |
| `<C-l>` | 移动到右侧窗口 |

### 快速移动
| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-j>` | Normal/Visual | 向下移动 5 行 |
| `<C-k>` | Normal/Visual | 向上移动 5 行 |
| `<C-d>` | Normal | 向下半页并居中 |
| `<C-u>` | Normal | 向上半页并居中 |

### 缓冲区导航
| 快捷键 | 功能 |
|--------|------|
| `<S-l>` / `]b` | 下一个缓冲区 |
| `<S-h>` / `[b` | 上一个缓冲区 |
| `<leader>bd` | 删除缓冲区 |
| `<leader>bp` | 固定缓冲区 |

### 移动
| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `H` | Normal/Visual | 移动到行首 |
| `L` | Normal/Visual | 移动到行尾 |
| `<C-d>` | Normal | 向下半页并居中 |
| `<C-u>` | Normal | 向上半页并居中 |
| `<A-j>` | Normal/Visual | 向下移动行 |
| `<A-k>` | Normal/Visual | 向上移动行 |

## 编辑

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<` | Visual | 减少缩进 (保持选中) |
| `>` | Visual | 增加缩进 (保持选中) |
| `p` | Visual | 粘贴 (不覆盖寄存器) |
| `<leader>d` | Normal/Visual | 删除不覆盖寄存器 |
| `<C-a>` | Normal | 全选 |
| `<C-S-d>` | Normal | 复制当前行 |

## 分屏

| 快捷键 | 功能 |
|--------|------|
| `<leader>sv` | 垂直分屏 |
| `<leader>sh` | 水平分屏 |
| `<leader>sx` | 关闭当前分屏 |
| `<C-Up>` | 增加窗口高度 |
| `<C-Down>` | 减少窗口高度 |
| `<C-Left>` | 减少窗口宽度 |
| `<C-Right>` | 增加窗口宽度 |

## 文件管理

| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 切换文件浏览器 (neo-tree) |
| `<leader>o` | 聚焦文件浏览器 |

### Neo-tree 内部快捷键
| 快捷键 | 功能 |
|--------|------|
| `<Space>` / `<CR>` | 打开/折叠节点 |
| `S` | 水平分屏打开 |
| `s` | 垂直分屏打开 |
| `t` | 在新标签页打开 |
| `a` | 添加文件 |
| `A` | 添加目录 |
| `d` | 删除 |
| `r` | 重命名 |
| `y` | 复制到剪贴板 |
| `x` | 剪切到剪贴板 |
| `p` | 粘贴 |
| `R` | 刷新 |
| `?` | 显示帮助 |

## 搜索与查找 (Telescope)

| 快捷键 | 功能 |
|--------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索文本 |
| `<leader>fb` | 查找缓冲区 |
| `<leader>fh` | 查找帮助标签 |
| `<leader>fr` | 最近打开的文件 |
| `<leader>fc` | 搜索光标下的字符串 |
| `<leader>fp` | 查找项目 |

## LSP (代码智能)

### 导航
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gi` | 跳转到实现 |
| `gr` | 查找引用 |
| `gt` | 跳转到类型定义 |
| `K` | 显示悬停文档 |
| `<C-k>` | 签名帮助 |

### 代码操作
| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>ca` | Normal/Visual | 代码操作 |
| `<leader>rn` | Normal | 重命名符号 |
| `<leader>fm` | Normal | 格式化文档 |

### 诊断
| 快捷键 | 功能 |
|--------|------|
| `[d` | 上一个诊断 |
| `]d` | 下一个诊断 |
| `<leader>df` | 显示诊断浮窗 |
| `<leader>dl` | 列出所有诊断 |

### 符号
| 快捷键 | 功能 |
|--------|------|
| `<leader>ds` | 文档符号 |
| `<leader>ws` | 工作区符号 |

### 工作区
| 快捷键 | 功能 |
|--------|------|
| `<leader>wa` | 添加工作区文件夹 |
| `<leader>wr` | 移除工作区文件夹 |
| `<leader>wl` | 列出工作区文件夹 |

### 其他
| 快捷键 | 功能 |
|--------|------|
| `<leader>uh` | 切换内联提示 |

## Git

| 快捷键 | 功能 |
|--------|------|
| `<leader>gg` | 打开 LazyGit |
| `<leader>gf` | 当前文件的 LazyGit |
| `<leader>gd` | 打开 DiffView |
| `<leader>gh` | 文件历史 |
| `<leader>gb` | Git 分支 |
| `<leader>gc` | Git 提交 |
| `<leader>gs` | Git 状态 |

### Git Hunks (Gitsigns)
| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `]h` | Normal | 下一个改动 |
| `[h` | Normal | 上一个改动 |
| `<leader>hs` | Normal/Visual | 暂存改动 |
| `<leader>hr` | Normal/Visual | 重置改动 |
| `<leader>hS` | Normal | 暂存整个文件 |
| `<leader>hu` | Normal | 撤销暂存 |
| `<leader>hR` | Normal | 重置整个文件 |
| `<leader>hp` | Normal | 预览改动 |
| `<leader>hb` | Normal | 查看 blame |
| `<leader>hd` | Normal | 差异对比 |

### Git 冲突
| 快捷键 | 功能 |
|--------|------|
| `co` | 选择我们的改动 |
| `ct` | 选择他们的改动 |
| `cb` | 保留双方改动 |
| `c0` | 不选择任何改动 |
| `]x` | 下一个冲突 |
| `[x` | 上一个冲突 |

## 注释

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `gcc` | Normal | 注释/取消注释行 |
| `gc` | Normal/Visual | 注释 |
| `gbc` | Normal | 块注释 |
| `gb` | Normal/Visual | 块注释 |
| `gcO` | Normal | 在上方添加注释 |
| `gco` | Normal | 在下方添加注释 |
| `gcA` | Normal | 在行尾添加注释 |

## 终端

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-\>` | Normal/Insert/Terminal | 切换终端 |
| `<ESC>` | Terminal | 退出终端模式 |

## 代码补全 (nvim-cmp)

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<C-Space>` | Insert | 触发补全 |
| `<C-e>` | Insert | 关闭补全 |
| `<CR>` | Insert | 确认补全 |
| `<Tab>` | Insert | 下一个补全项 / 跳转片段 |
| `<S-Tab>` | Insert | 上一个补全项 / 跳转片段 |
| `<C-b>` | Insert | 向上滚动文档 |
| `<C-f>` | Insert | 向下滚动文档 |

## Trouble (诊断查看器)

| 快捷键 | 功能 |
|--------|------|
| `<leader>xx` | 切换文档诊断 |
| `<leader>xX` | 切换工作区诊断 |
| `<leader>xL` | 位置列表 |
| `<leader>xQ` | 快速修复列表 |
| `<leader>xt` | Todo 注释 |

## Todo 注释

| 快捷键 | 功能 |
|--------|------|
| `]t` | 下一个 todo 注释 |
| `[t` | 上一个 todo 注释 |
| `<leader>ft` | 搜索 todo 注释 |

## 会话管理

| 快捷键 | 功能 |
|--------|------|
| `<leader>qs` | 恢复会话 |
| `<leader>ql` | 恢复上次会话 |
| `<leader>qd` | 不保存当前会话 |

## 其他

| 快捷键 | 功能 |
|--------|------|
| `<leader>cm` | 打开 Mason |
| `<leader>un` | 关闭通知 |
| `<C-space>` | 增量选择 (Treesitter) |
| `<bs>` | 减量选择 (Treesitter) |

## Text Objects (Treesitter)

| 快捷键 | 功能 |
|--------|------|
| `af` | 外部函数 |
| `if` | 内部函数 |
| `ac` | 外部类 |
| `ic` | 内部类 |
| `aa` | 外部参数 |
| `ia` | 内部参数 |
| `]m` | 下一个函数开始 |
| `]M` | 下一个函数结束 |
| `[m` | 上一个函数开始 |
| `[M` | 上一个函数结束 |
| `]]` | 下一个类开始 |
| `][` | 下一个类结束 |
| `[[` | 上一个类开始 |
| `[]` | 上一个类结束 |

## 包围 (nvim-surround)

| 快捷键 | 功能示例 |
|--------|----------|
| `ys{motion}{char}` | 添加包围, 例如 `ysiw"` 用引号包围单词 |
| `ds{char}` | 删除包围, 例如 `ds"` 删除引号 |
| `cs{old}{new}` | 改变包围, 例如 `cs"'` 将双引号改为单引号 |
| `yss{char}` | 包围整行 |
| `ySS{char}` | 包围整行并换行缩进 |
| `S{char}` | 在 Visual 模式下包围选中内容 |
