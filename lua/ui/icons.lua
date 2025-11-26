-- ============================================================================
-- UI Icons Configuration
-- Unified icon definitions for consistent and beautiful UI
-- ============================================================================

local M = {}

-- ============================================================================
-- File Type Icons (used by neo-tree, telescope, etc.)
-- ============================================================================
M.file_icons = {

  -- Default
  default = '',
  symlink = '',

  -- Special files
  ['README.md'] = '󰍔',
  ['readme.md'] = '󰍔',
  ['.gitignore'] = '',
  ['.gitattributes'] = '',
  ['.gitmodules'] = '',
  ['.editorconfig'] = '',
  ['.prettierrc'] = '󰏣',
  ['.eslintrc'] = '󰱺',
  ['package.json'] = '',
  ['package-lock.json'] = '',
  ['tsconfig.json'] = '',
  ['webpack.config.js'] = '󰜫',
  ['vite.config.js'] = '󰡄',
  ['Dockerfile'] = '󰡨',
  ['docker-compose.yml'] = '󰡨',
  ['.env'] = '',
  ['LICENSE'] = '󰿃',
  ['Makefile'] = '',
}

-- ============================================================================
-- Git Status Icons
-- ============================================================================
M.git_icons = {
  -- Git signs (gutter)
  added = '┃',
  modified = '┃',
  removed = '▁',
  topdelete = '▔',
  changedelete = '~',
  untracked = '┆',

  -- Git status (neo-tree, telescope, etc.)
  -- unstaged = '󰄱',
  staged = '',
  unmerged = '',
  renamed = '➜',
  deleted = '',
  ignored = '',
}

-- ============================================================================
-- LSP & Diagnostics Icons
-- ============================================================================
M.diagnostics = {
  error = '',
  warn = '',
  hint = '󰌵',
  info = '',
}

M.lsp_kinds = {
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}

-- ============================================================================
-- UI Component Icons
-- ============================================================================
M.ui = {
  -- General
  arrow_right = '',
  arrow_left = '',
  arrow_up = '',
  arrow_down = '',

  -- Status
  check = '',
  cross = '',
  circle = '',
  circle_filled = '',

  -- Misc
  lock = '',
  unlock = '',
  search = '',
  bookmark = '',
  tag = '',
  fire = '',
  gear = '',
  package = '',
  list = '',

  -- Borders
  border = 'rounded',
}

-- ============================================================================
-- Terminal Icons
-- ============================================================================
M.terminal = {
  prompt = '',
  shell = '',
}

-- ============================================================================
-- Bufferline Icons
-- ============================================================================
M.bufferline = {
  buffer_close = '󰅖',
  modified = '●',
  pinned = '󰐃',
  separator = '▎',
}

-- ============================================================================
-- Mason Icons
-- ============================================================================
M.mason = {
  package_installed = '✓',
  package_pending = '➜',
  package_uninstalled = '✗',
}

-- ============================================================================
-- DAP (Debug Adapter Protocol) Icons
-- ============================================================================
M.dap = {
  breakpoint = '',
  breakpoint_condition = '',
  breakpoint_rejected = '',
  log_point = '',
  stopped = '',
}

-- ============================================================================
-- Telescope Icons
-- ============================================================================
M.telescope = {
  prompt_prefix = '  ',
  selection_caret = ' ',
  entry_prefix = '  ',
}

-- ============================================================================
-- Alpha (Dashboard) Icons
-- ============================================================================
M.alpha = {
  find_file = '  ',
  new_file = '  ',
  recent_files = '  ',
  find_text = '  ',
  config = '  ',
  lazy = '󰒲  ',
  quit = '  ',
}

return M
