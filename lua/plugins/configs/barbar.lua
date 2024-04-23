local success, barbar = pcall(require, 'barbar')

if not success then
  return
end

barbar.setup({
  animation = true,
  tabpages = true,
  icons = {
    button = false,
    separator = { left = '' },
    inactive = {
      separator = { left = '' },
    },
    modified = {button = '●'},
    pinned = { button = '車', filename = true },
    inactive = {button = '×'},

  },
  sidebar_filetypes = {
    NvimTree = true,
  },
  no_name_title = 'New File',
})
