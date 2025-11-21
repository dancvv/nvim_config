-- ============================================================================
-- Core Options
-- Vim settings for modern development
-- ============================================================================

local opt = vim.opt
local g = vim.g

-- ============================================================================
-- Leader Key
-- ============================================================================
g.mapleader = ";"        -- Semicolon as leader key
g.maplocalleader = ";"

-- ============================================================================
-- General Settings
-- ============================================================================
opt.mouse = "a"              -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false         -- No swap files
opt.backup = false           -- No backup files
opt.writebackup = false      -- No backup before writing
opt.undofile = true          -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ============================================================================
-- UI Settings
-- ============================================================================
opt.number = true            -- Show line numbers
opt.relativenumber = false    -- Relative line numbers
opt.cursorline = true        -- Highlight current line
opt.signcolumn = "yes"       -- Always show sign column
opt.colorcolumn = "80"       -- Show column ruler at 80
opt.termguicolors = true     -- True color support
opt.showmode = false         -- Don't show mode (statusline shows it)
opt.wrap = false             -- No line wrap
opt.scrolloff = 8            -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8        -- Keep 8 columns left/right of cursor
opt.pumheight = 10           -- Max items in popup menu

-- ============================================================================
-- Editing
-- ============================================================================
opt.expandtab = true         -- Use spaces instead of tabs
opt.shiftwidth = 2           -- Indent width
opt.tabstop = 2              -- Tab width
opt.softtabstop = 2          -- Tab width for editing
opt.smartindent = true       -- Smart auto-indenting
opt.autoindent = true        -- Copy indent from current line
opt.breakindent = true       -- Wrapped lines keep indentation

-- ============================================================================
-- Search
-- ============================================================================
opt.ignorecase = true        -- Ignore case in search
opt.smartcase = true         -- Unless search contains uppercase
opt.hlsearch = true          -- Highlight search results
opt.incsearch = true         -- Incremental search

-- ============================================================================
-- Splits
-- ============================================================================
opt.splitright = true        -- Vertical splits open to the right
opt.splitbelow = true        -- Horizontal splits open below

-- ============================================================================
-- Performance
-- ============================================================================
opt.updatetime = 250         -- Faster completion (default 4000ms)
opt.timeoutlen = 300         -- Faster key sequence completion
opt.lazyredraw = false       -- Don't redraw during macros (can cause issues)

-- ============================================================================
-- Command Line
-- ============================================================================
opt.cmdheight = 1            -- Command line height
opt.showcmd = true           -- Show command in statusline
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options

-- ============================================================================
-- File Handling
-- ============================================================================
opt.fileencoding = "utf-8"   -- File encoding
opt.conceallevel = 0         -- Don't hide characters
opt.hidden = true            -- Allow hidden buffers

-- ============================================================================
-- Folding (for nvim-ufo)
-- ============================================================================
opt.foldcolumn = "0"         -- No fold column
opt.foldlevel = 99           -- Open all folds by default
opt.foldlevelstart = 99      -- Open all folds by default
opt.foldenable = true        -- Enable folding

-- ============================================================================
-- Session
-- ============================================================================
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ============================================================================
-- Disable built-in plugins
-- ============================================================================
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
