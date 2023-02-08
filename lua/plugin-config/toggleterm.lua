local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("Not found toggleterm")
  return
end

toggleterm.setup{
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  -- 打开新终端后自动进入插入模式
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  -- 在当前buffer的位置打开终端，可选float,horizontal,tab
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}


-- 快速退出当前窗口
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<A-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<A-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<A-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<A-l>', [[<Cmd>wincmd l<CR>]], opts)
  -- macos key set
  vim.keymap.set('t', '˙', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '∆', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '˚', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '¬', [[<Cmd>wincmd l<CR>]], opts)
end

