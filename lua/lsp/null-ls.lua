local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("Not found null_ls")
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- formatting -------
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    formatting.prettier.with({
      filetypes = {
        "javascript",
      }
    }),
    -- gitsigns
    null_ls.builtins.code_actions.gitsigns,
  },

})

