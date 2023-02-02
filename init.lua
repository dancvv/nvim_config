-- basic configuration
require('basic')
require('plugins')
require('colorscheme')
require('plugin-config.nvim-tree')
require('plugin-config.bufferline')
require('plugin-config.lualine')
require('plugin-config.telescope')
require('plugin-config.multi-cursor')
require('plugin-config.surround')
require('plugin-config.leap')

if vim.g.vscode then
  require('vskeybindings')
else
  require('keybindings')
  require('lsp.cmp')
  require('lsp.setup')
  require('plugin-config.treesitter')
  --require('plugin-config.dashboard')
end
