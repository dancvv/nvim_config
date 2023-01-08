-- buffline setting
-- config the headline
local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    vim.notify("not found bufferline")
  return
end

