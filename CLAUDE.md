s CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **modern, modular Neovim configuration** designed for professional development with VSCode-like features. It provides intelligent code completion, syntax highlighting, LSP integration, efficient Git management, and a clean, organized structure.

**Target Languages**: Vue3, React, TypeScript, JavaScript, Go, Python, Lua

**Philosophy**: Clean architecture, lazy loading for performance, intuitive VSCode-inspired keybindings.

## Quick Start

### First Time Setup

```bash
# Open Neovim - lazy.nvim will auto-install
nvim

# Inside Neovim - install all LSP servers and tools
:Lazy sync
:checkhealth
```

Mason will automatically install all configured tools on first run.

### Essential Commands

```vim
:Lazy                " Plugin manager UI
:Mason               " LSP/tool installer UI
:checkhealth         " Check configuration health
:Telescope           " Fuzzy finder
:Neotree toggle      " File explorer
:LazyGit             " Git UI
```

### Maintenance

```vim
:Lazy sync           " Update all plugins
:Mason               " Manage LSP servers/tools
:TSUpdate            " Update Treesitter parsers
```

## Architecture

### Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - loads core and plugins
├── KEYMAPS.md                  # Complete keybinding reference
├── CLAUDE.md                   # This file
├── lua/
│   ├── core/                   # Core configuration
│   │   ├── init.lua            # Loads options, keymaps, autocmds
│   │   ├── options.lua         # All vim settings
│   │   ├── keymaps.lua         # Global key mappings
│   │   └── autocmds.lua        # Auto commands
│   ├── plugins/                # Plugin specifications (lazy.nvim)
│   │   ├── init.lua            # Plugin manager bootstrap
│   │   ├── ui.lua              # UI plugins (theme, statusline, bufferline)
│   │   ├── editor.lua          # Editor enhancements (neo-tree, telescope, comments)
│   │   ├── lsp.lua             # LSP plugins (lspconfig, mason, conform, lint)
│   │   ├── coding.lua          # Coding plugins (cmp, treesitter, snippets)
│   │   ├── git.lua             # Git integration (gitsigns, lazygit, diffview)
│   │   └── tools.lua           # Tools (terminal, session, project)
│   └── lsp/                    # LSP configuration
│       ├── setup.lua           # LSP server configurations
│       ├── handlers.lua        # LSP handlers and capabilities
│       └── keymaps.lua         # LSP-specific keymaps
```

### Initialization Flow

1. **`init.lua`** → Entry point
2. **`core/init.lua`** → Loads core modules (options, keymaps, autocmds)
3. **`plugins/init.lua`** → Bootstraps lazy.nvim and imports all plugin specs
4. **Lazy.nvim** → Automatically loads plugins from `plugins/*.lua` files
5. **LSP** → Configured via `lsp/*.lua` when LSP plugins load

### Key Design Patterns

**Pattern 1: Modular Plugin Organization**

- Each `plugins/*.lua` file returns a table of plugin specifications
  Plugins are categorized by function: ui, editor, lsp, coding, git, tools
- All plugins use lazy loading (event, cmd, keys, ft) for performance

**Pattern 2: Lazy Loading Strategy**

- `event = "VeryLazy"` - Load after startup
- `event = { "BufReadPost", "BufNewFile" }` - Load when opening files
- `cmd = "CommandName"` - Load on command execution
- `keys = { ... }` - Load on keypress
- `ft = "filetype"` - Load for specific file types

**Pattern 3: LSP Three-Layer Architecture**

**Layer 1: Plugin Management** (`plugins/lsp.lua`)

- Defines LSP-related plugins (lspconfig, mason, conform, lint)
- Handles plugin installation and updates
- Ensures tools are installed via Mason

**Layer 2: LSP Configuration** (`lsp/setup.lua`)

- Contains server-specific settings for each language
- Uses mason-lspconfig for automatic server setup
- Merges capabilities and on_attach handlers

**Layer 3: LSP Behavior** (`lsp/handlers.lua` & `lsp/keymaps.lua`)

- Handlers: Diagnostics config, floating window borders, capabilities
- Keymaps: All LSP keybindings set via LspAttach autocmd

**Pattern 4: Centralized Configuration**

- All vim options in one file: `core/options.lua`
- All global keymaps in one file: `core/keymaps.lua`
- LSP keymaps separate: `lsp/keymaps.lua` (attached per buffer)
- Complete keymap reference: `KEYMAPS.md`

## Language Configuration

### Currently Configured Languages

**LSP Servers** (auto-installed via Mason):

- **Lua**: lua_ls (with vim globals)
- **TypeScript/JavaScript**: ts_ls (with inlay hints)
- **Vue**: volar (hybrid mode)
- **Go**: gopls (with staticcheck, gofumpt, inlay hints)
- **Python**: pyright (basic type checking)
- **HTML/CSS/JSON**: html, cssls, jsonls, yamlls
- **Tailwind**: tailwindcss
- **ESLint**: eslint

**Formatters** (via conform.nvim):

- Lua: stylua
- Python: isort, black
- JS/TS/Vue/CSS/HTML/JSON: prettierd (or prettier fallback)
- Go: goimports, gofumpt

**Linters** (via nvim-lint):

- JS/TS/Vue: eslint_d

### Adding a New Language

1. **Add LSP server** in `lua/lsp/setup.lua`:

```lua
local servers = {
  -- Add your server
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
      },
    },
  },
}
```

2. **Add to Mason ensure_installed** in `lua/plugins/lsp.lua`:

```lua
ensure_installed = {
  "rust-analyzer",  -- Add here
  -- ...
}
```

3. **Add formatter** in `lua/plugins/lsp.lua` (conform.nvim config):

```lua
formatters_by_ft = {
  rust = { "rustfmt" },  -- Add here
}
```

4. **Add Treesitter parser** in `lua/plugins/coding.lua`:

```lua
ensure_installed = {
  "rust",  -- Add here
  -- ...
}
```

5. **Restart Neovim** and run `:Lazy sync` → `:checkhealth`

## Important Configuration Details

### Leader Key

**Leader = Semicolon (`;`)** (configured in `core/options.lua:12`)

All leader keybindings use semicolon as the prefix.

### Core Keybindings

See `KEYMAPS.md` for complete reference. Key highlights:

- **File Explorer**: `<leader>e` (toggle), `<leader>o` (focus)
- **Find Files**: `<leader>ff`
- **Live Grep**: `<leader>fg`
- **Git UI**: `<leader>gg`
- **LSP Actions**: `gd` (definition), `gr` (references), `<leader>ca` (code action), `<leader>rn` (rename)
- **Diagnostics**: `[d` / `]d` (navigate), `<leader>df` (show)
- **Format**: `<leader>fm`
- **Terminal**: `<C-\>`

### LSP Keybindings

All LSP keybindings are set automatically when LSP attaches to a buffer (via `LspAttach` autocmd in `lsp/keymaps.lua`).

**Navigation**:

- `gd` - Go to definition (Telescope)
- `gi` - Go to implementation (Telescope)
- `gr` - Go to references (Telescope)
- `gt` - Go to type definition (Telescope)
- `K` - Hover documentation

**Actions**:

- `<leader>ca` - Code action
- `<leader>rn` - Rename symbol
- `<leader>fm` - Format document

**Diagnostics**:

- `[d` / `]d` - Previous/next diagnostic
- `<leader>df` - Show diagnostic in float
- `<leader>dl` - List all diagnostics (Telescope)

### Format-on-Save

Configured via **conform.nvim** in `plugins/lsp.lua`:

```lua
format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true,
}
```

Files are automatically formatted on save. If no formatter is configured for a filetype, it falls back to LSP formatting.

To format manually: `<leader>fm`

To check formatter status: `:ConformInfo`

### Linting

Configured via **nvim-lint** in `plugins/lsp.lua`. Linting runs automatically on:

- Buffer enter
- After save
- Leaving insert mode

### Git Integration

**Three-tier Git integration**:

1. **gitsigns** - Inline git change indicators and hunk operations
   - `]h` / `[h` - Navigate hunks
   - `<leader>hs` - Stage hunk
   - `<leader>hp` - Preview hunk
   - `<leader>hb` - Blame line

2. **LazyGit** - Full-featured Git TUI
   - `<leader>gg` - Open LazyGit
   - Complete Git workflow in terminal UI

3. **DiffView** - Advanced diff viewing
   - `<leader>gd` - Open DiffView
   - `<leader>gh` - File history

4. **git-conflict** - Merge conflict resolution
   - `co` / `ct` / `cb` - Choose ours/theirs/both
   - `]x` / `[x` - Navigate conflicts

### Auto Commands

Defined in `core/autocmds.lua`:

- **Highlight on yank** - Flash yanked text
- **Trim whitespace** - Remove trailing whitespace on save
- **Restore cursor** - Return to last position when opening file
- **Close with q** - Help, quickfix, etc. close with `q`
- **Auto-create directories** - Create parent dirs when saving
- **Resize splits** - Equalize splits on window resize
- **File-specific settings** - Wrap/spell for text files, indentation for Go/Python

### Treesitter Text Objects

Enhanced code navigation and manipulation:

- `af` / `if` - Outer/inner function
- `ac` / `ic` - Outer/inner class
- `aa` / `ia` - Outer/inner parameter
- `]m` / `[m` - Next/previous function
- `]]` / `[[` - Next/previous class

## Common Issues

### LSP Not Working

1. **Check if server is installed**:

```vim
:Mason
```

Look for your language server. If not installed, select it and press `i`.

2. **Check if server is running**:

```vim
:LspInfo
```

Should show attached clients.

3. **Check logs**:

```vim
:LspLog
```

4. **Restart LSP**:

```vim
:LspRestart
```

### Formatting Not Working

1. **Check formatter is installed**:

```vim
:Mason
```

2. **Check formatter configuration**:

```vim
:ConformInfo
```

Shows configured formatters for current filetype.

3. **Check if format-on-save is enabled**:
   Look in `plugins/lsp.lua` → conform.nvim config → `format_on_save`

4. **Try manual format**:

```vim
:lua vim.lsp.buf.format()
```

or press `<leader>fm`

### Completion Not Working

1. **Check LSP is running**: `:LspInfo`
2. **Check completion sources**: Type in insert mode and press `<C-Space>` to trigger
3. **Check cmp configuration**: `plugins/coding.lua` → nvim-cmp config

### Plugin Not Loading

1. **Check lazy loading condition**: Plugin might not load until you trigger its `keys`, `cmd`, or `event`
2. **Check plugin status**:

```vim
:Lazy
```

Shows all plugins and their load status.

3. **Force load**:

```vim
:Lazy load <plugin-name>
```

### Telescope Not Finding Files

1. **Check if in Git repo**: Telescope find_files uses Git by default
2. **Use fallback**: `<leader>ff` with hidden files
3. **Check ignore patterns**: `plugins/editor.lua` → telescope config → `file_ignore_patterns`

## Development Notes

### Adding New Plugins

1. **Choose the right category file**:
   - UI changes → `plugins/ui.lua`
   - Editor features → `plugins/editor.lua`
   - LSP related → `plugins/lsp.lua`
   - Completion/syntax → `plugins/coding.lua`
   - Git features → `plugins/git.lua`
   - Utilities → `plugins/tools.lua`

2. **Use lazy loading**:

```lua
{
  "author/plugin",
  event = "VeryLazy",  -- or cmd, keys, ft
  dependencies = { "required-plugin" },
  opts = { ... },
  config = function()
    require("plugin").setup({ ... })
  end,
}
```

3. **Restart and sync**:

```vim
:Lazy sync
```

### Modifying Keybindings

**Global keybindings** → `core/keymaps.lua`
**LSP keybindings** → `lsp/keymaps.lua`
**Plugin-specific keybindings** → In plugin spec's `keys` table

### Changing Theme

Currently uses **Catppuccin Mocha**. To change:

1. Edit `plugins/ui.lua` → colorscheme plugin
2. Update lualine theme in lualine config
3. Restart Neovim

### Performance Tuning

**Check startup time**:

```vim
:Lazy profile
```

**Optimize strategies**:

1. Increase lazy loading (use `event`, `cmd`, `keys` instead of eager loading)
2. Reduce `ensure_installed` parsers in Treesitter config
3. Disable unused LSP servers in Mason
4. Use `event = "VeryLazy"` for non-critical plugins

## File Type Specific

### Vue 3

- Uses **volar** in hybrid mode
- Auto-formats with prettier/prettierd
- Full `<script setup>` support

### React/TypeScript

- Uses **ts_ls** with inlay hints
- ESLint integration (LSP + linter)
- Auto-formats with prettier/prettierd

### Go

- Uses **gopls** with staticcheck
- Formats with goimports + gofumpt
- Inlay hints enabled for parameters and types
- Tab-based indentation (auto-configured)

### Python

- Uses **pyright** for type checking
- Formats with isort (imports) + black (code)
- 4-space indentation (auto-configured)

### Lua

- Uses **lua_ls** with `vim` global recognized
- Formats with stylua
- 2-space indentation

## Tips

### Session Management

- `<leader>qs` - Restore session for current directory
- `<leader>ql` - Restore last session
- Sessions auto-save on exit

### Project Navigation

- `<leader>fp` - Switch between projects (uses Telescope)
- Projects detected via `.git`, `package.json`, `Makefile`, etc.

### Terminal Usage

- `<C-\>` - Toggle floating terminal
- `<ESC>` - Exit terminal mode
- Terminal persists across toggles

### Git Workflow

1. Make changes
2. `<leader>hp` - Preview hunk
3. `<leader>hs` - Stage hunk (or visual selection)
4. `<leader>gg` - Open LazyGit for commit/push

### Debugging LSP Issues

```vim
:LspInfo        " Check attached clients
:LspLog         " View LSP logs
:LspRestart     " Restart LSP client
:Mason          " Check tool installation
:ConformInfo    " Check formatter config
:checkhealth    " Full health check
```

## Backup and Migration

**Backup created at**: `~/.config/nvim.backup.<timestamp>`

To restore old config:

```bash
cd ~/.config
rm -rf nvim
mv nvim.backup.<timestamp> nvim
```

To start fresh:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
