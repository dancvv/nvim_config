-- ============================================================================
-- Neovim Configuration Entry Point
-- Modern VSCode-like Development Experience
-- ============================================================================

-- Performance: Load core modules first (options, autocmds always load)
require("core")

if vim.g.vscode then
  -- ── Running inside VSCode (vscode-neovim extension) ──────────────────────
  -- Core keymaps still apply (motions, editing, etc.)
  -- VSCode handles: LSP, file search, git, terminal, statusline
  -- Neovim handles: editing, motions, text objects, surround, jump
  require("vscode_compat.keymaps")

  -- Load only editing-focused plugins (lazy.nvim still bootstraps)
  require("plugins")
else
  -- ── Standalone Neovim ────────────────────────────────────────────────────
  require("plugins")
end
