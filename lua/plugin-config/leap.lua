local status, leap = pcall(require, "leap")
if not status then
    vim.notify("not found leap")
  return
end

leap.add_default_mappings()
