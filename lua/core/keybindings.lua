local bind = vim.keymap.set
-- 复用 opt 参数
local opt = {noremap = true, silent = true }


vim.g.mapleader = ';'

vim.opt.langmap = 'ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,'
  .. 'ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,'
  .. 'σs,τt,θu,ωv,ςw,χx,υy,ζz'

-- Unbind 'K'
bind('n', 'K', '<NOP>', opt)

-- Copy selected text
-- maps.v["<C-c"] = {"+y", desc = "Copy selected content"}
bind('v', '<C-c>', '"+y', opt)
-- Exit insert mode
bind('i', 'jk', '<ESC>', opt)
bind('i', 'ξκ', '<ESC>', opt)

-- Jump to the beginning of the line
-- Jump to the end of the line
bind('n', 'H', '^', opt)
bind('v', 'H', '^', opt)
bind('n', 'L', '$', opt)
bind('v', 'L', '$', opt)

-- Move down and up 5 lines
bind('n', '<C-j>', '5j', opt)
bind('n', '<C-k>', '5k', opt)

-- Stay in indent mode after indenting text
bind('v', '<', '<gv', opt)
bind('v', '>', '>gv', opt)

-- Move text up and down
bind('x', 'J', ":move '>+1<CR>gv")
bind('x', 'K', ":move '<-2<CR>gv")

-- Clear highlights and prints
bind('n', '<LEADER>n', '<CMD>noh<CR><cmd>echo ""<CR>', opt)

-- Copy path to clipboard
bind('n', '<LEADER>yf', '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:."))<CR>', opt)
bind('n', '<LEADER>yl', '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))<CR>', opt)

-- TUI/GUI NeoVim only settings
if not vim.g.vscode then
  -- Resize with arrows
  bind('n', '<C-Up>', '<CMD>resize +2<CR>', opt)
  bind('n', '<C-Down>', '<CMD>resize -2<CR>', opt)
  bind('n', '<C-Left>', '<CMD>vertical resize -2<CR>', opt)
  bind('n', '<C-Right>', '<CMD>vertical resize +2<CR>', opt)

  -- Improve window navigation
  bind('n', '<C-h>', '<C-w>h', opt)
  -- bind('n', '<C-j>', '<C-w>j', opt)
  -- bind('n', '<C-k>', '<C-w>k', opt)
  bind('n', '<C-l>', '<C-w>l', opt)
  bind('t', '<ESC><ESC>', '<C-\\><C-n>', opt)
  bind('t', '<C-h>', '<CMD>wincmd h<CR>', opt)
  bind('t', '<C-j>', '<CMD>wincmd j<CR>', opt)
  bind('t', '<C-k>', '<CMD>wincmd k<CR>', opt)
  bind('t', '<C-l>', '<CMD>wincmd l<CR>', opt)

  -- Tab navigation
  bind('n', '<LEADER>tt', '<CMD>tabnew %<CR>', opt)
  bind('n', '<LEADER>tq', '<CMD>tabclose<CR>', opt)
  bind('n', '<LEADER>tn', '<CMD>tabnext<CR>', opt)
  bind('n', '<LEADER>tp', '<CMD>tabprev<CR>', opt)

  -- Delete selection into void register before pasting
  bind('x', '<LEADER>p', '"_dP', opt)

  -- LSP
  bind('n', '<LEADER>k', vim.diagnostic.open_float, opt)
  bind('n', '[d', vim.diagnostic.goto_prev, opt)
  bind('n', ']d', vim.diagnostic.goto_next, opt)

  -- nvimtree
  bind("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
  bind("n", "<leader>e", ":NvimTreeFocus<CR>", opt)

  -- treesitter
  bind("n", "<leader>i", "gg=G", opt)


end
