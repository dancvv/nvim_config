local opt = vim.opt

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath('state') .. '/undo'

opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = 'yes'
opt.colorcolumn = '100'
opt.termguicolors = true
opt.showmode = false
opt.shortmess:append('I')
opt.laststatus = 3
opt.showtabline = 1
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 6
opt.sidescrolloff = 6
opt.pumheight = 12
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '', diff = '╱' }

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.virtualedit = 'block'

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = 'split'

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'

opt.updatetime = 200
opt.timeoutlen = 300
opt.redrawtime = 10000
opt.smoothscroll = true

opt.confirm = true
opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
opt.conceallevel = 0
opt.hidden = true
opt.diffopt:append('linematch:60')

opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
