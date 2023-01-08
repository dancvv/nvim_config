local status, surround = pcall(require, "nvim-surround")
if not status then
  vim.notify("not found nvim-surround")
  return
end

surround.setup({
})
