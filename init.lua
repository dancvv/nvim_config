-- require lazy config
require("config.keymaps")
require("config.lazy")
require("config.options")

-- vscode envirment
if vim.g.vscode then
  require('config.vskeymaps')
end

