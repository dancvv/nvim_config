-- ============================================================================
-- Core Keymaps
-- VSCode-inspired keybindings for intuitive workflow
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General Mappings
-- ============================================================================

-- Better escape
keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kj', '<ESC>', opts)

-- Better move
keymap('n', '<C-j>', '5j', opts)
keymap('n', '<C-k>', '5k', opts)

-- Save and quit
keymap('n', '<C-s>', '<cmd>w<CR>', opts)
keymap('i', '<C-s>', '<ESC><cmd>w<CR>', opts)
keymap('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
keymap('n', '<leader>Q', '<cmd>qa!<CR>', { desc = 'Quit all without saving' })

-- Clear search highlighting
keymap('n', '<ESC>', '<cmd>nohlsearch<CR>', opts)

-- ============================================================================
-- Navigation
-- ============================================================================

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Fast vertical movement (5 lines at a time)
keymap('n', '<C-j>', '5j', opts)
keymap('n', '<C-k>', '5k', opts)
keymap('v', '<C-j>', '5j', opts)
keymap('v', '<C-k>', '5k', opts)

-- Navigate buffers
keymap('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })

-- Move to start/end of line
keymap({ 'n', 'v' }, 'H', '^', opts)
keymap({ 'n', 'v' }, 'L', '$', opts)

-- Move lines up and down
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Better vertical movement
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Keep cursor centered when searching
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- ============================================================================
-- Editing
-- ============================================================================

-- Better indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Paste without yanking in visual mode
keymap('v', 'p', '"_dP', opts)

-- Delete without yanking
keymap({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yank' })

-- Select all
keymap('n', '<C-a>', 'ggVG', opts)

-- Duplicate line
keymap('n', '<C-S-d>', 'yyp', { desc = 'Duplicate line' })

-- ============================================================================
-- Split Windows
-- ============================================================================

keymap('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split vertical' })
keymap('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split horizontal' })
keymap('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close split' })

-- Resize windows
keymap('n', '<C-Up>', '<cmd>resize +2<CR>', opts)
keymap('n', '<C-Down>', '<cmd>resize -2<CR>', opts)
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>', opts)

-- ============================================================================
-- Plugin Keymaps (will be used when plugins are loaded)
-- ============================================================================

-- File Explorer (neo-tree)
keymap('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })
keymap('n', '<leader>o', '<cmd>Neotree focus<CR>', { desc = 'Focus file explorer' })

-- Telescope
keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Help tags' })
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', { desc = 'Recent files' })
keymap('n', '<leader>fc', '<cmd>Telescope grep_string<CR>', { desc = 'Find string under cursor' })
keymap('n', '<leader>fp', '<cmd>Telescope projects<CR>', { desc = 'Find projects' })

-- Git
keymap('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'LazyGit' })
keymap('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', { desc = 'Git branches' })
keymap('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'Git commits' })
keymap('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = 'Git status' })

-- LSP keymaps will be set in lsp/keymaps.lua

-- Terminal
keymap('n', '<C-\\>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
keymap('t', '<C-\\>', '<cmd>ToggleTerm<CR>', opts)
keymap('t', '<ESC>', '<C-\\><C-n>', opts)

-- Code actions
keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code action' })
keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
keymap('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { desc = 'Format' })

-- Diagnostics
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous diagnostic' })
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next diagnostic' })
keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', { desc = 'List diagnostics' })

-- Comment (will work with Comment.nvim)
keymap('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)', { desc = 'Comment line' })
keymap('v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment selection' })

-- Trouble (diagnostics viewer)
keymap('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { desc = 'Toggle trouble' })
keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Workspace diagnostics' })
keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', { desc = 'Document diagnostics' })
