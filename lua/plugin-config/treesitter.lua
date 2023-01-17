local status, treesitter = pcall(require, "nvim-treesitter.configs")

if not status then
  vim.notify("Not found nvim-treesitter")
  return
end

treesitter.setup({
  -- install language parser
  ensure_isntalled = {"json", "vim", "lua", "java", "help", "javascript"},
  auto_install = true,
  -- enable code highlight module
  highlight = {
    enable = true,
    additonal_vim_regex_highlighting = false,
  }
})
