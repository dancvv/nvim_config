-- ============================================================================
-- Plugin Management with lazy.nvim
-- Bootstrap and load all plugins
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Import plugin specifications from lua/plugins
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.lsp" },
  { import = "plugins.coding" },
  { import = "plugins.git" },
  { import = "plugins.tools" },
}, {
  -- Lazy.nvim configuration
  defaults = {
    lazy = true, -- Lazy load plugins by default
    version = false, -- Use latest git commit
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  checker = {
    enabled = true, -- Check for plugin updates
    notify = false, -- Don't notify about updates
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})
