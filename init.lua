-- basic configuration
require('basic')
require('plugins')
require('colorscheme')
require('plugin-config.multi-cursor')
require('plugin-config.surround')
require('plugin-config.leap')
require('plugin-config.comment')

if vim.g.vscode then
  require('vskeybindings')
else
  require('keybindings')
  require('lsp.cmp')
  require('lsp.setup')
  require('lsp.null-ls')
  require('plugin-config.treesitter')
  require('plugin-config.telescope')
  require('plugin-config.nvim-tree')
  require('plugin-config.bufferline')
  require('plugin-config.lualine')
end

