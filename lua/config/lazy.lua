local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local output = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to install lazy.nvim\n', 'ErrorMsg' },
      { output, 'WarningMsg' },
    }, true, {})
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins.ui' },
  { import = 'plugins.editor' },
  { import = 'plugins.coding' },
  { import = 'plugins.lsp' },
  { import = 'plugins.git' },
  { import = 'plugins.ai' },
  { import = 'plugins.tools' },
  { import = 'plugins.dap' },
}, {
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { 'catppuccin', 'habamax' },
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  rocks = { enabled = false },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = { border = 'rounded' },
})
