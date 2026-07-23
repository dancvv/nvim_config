if vim.loader then
  vim.loader.enable()
end

vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

require('config')

if vim.g.vscode then
  require('vscode_compat.keymaps')
else
  require('config.lazy')
end
