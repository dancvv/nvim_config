-- keymapping
vim.api.nvim_exec(
  [[
    let g:VM_leader = ';'
    let g:VM_maps = {}
    let g:VM_maps['Find Under']         = '<C-n>'
    let g:VM_maps['Find Subword Under'] = '<C-n>'
    let g:VM_maps["Add Cursor Down"]    = '<C-q>'
    let g:VM_maps["Add Cursor Up"]      = '<Leader>n'

  ]], false
)
