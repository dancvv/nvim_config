-- ============================================================================
-- Core Keymaps
-- VSCode-inspired keybindings for intuitive workflow
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General Mappings
-- ============================================================================

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

-- System clipboard keybindings (platform-specific)

-- Copy to system clipboard
keymap('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
keymap('n', '<C-c>', '"+yy', { desc = 'Copy line to system clipboard' })

-- Cut to system clipboard
keymap('v', '<C-x>', '"+d', { desc = 'Cut to system clipboard' })

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
-- Terminal
-- ============================================================================

-- Exit terminal mode (plugin-independent, not handled by toggleterm)
keymap('t', '<ESC>', '<C-\\><C-n>', opts)

-- ============================================================================
-- Comments
-- ============================================================================

-- remap = true delegates to Comment.nvim plugin mappings (gcc / gc)
keymap('n', '<C-/>', 'gcc', { desc = 'Comment line', remap = true })
keymap('v', '<C-/>', 'gc', { desc = 'Comment selection', remap = true })

-- NOTE: All plugin-specific keymaps (file explorer, telescope, git, LSP,
-- diagnostics, terminal toggle, trouble) are defined in their plugin specs
-- using the `keys` option for proper lazy loading.
