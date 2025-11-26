-- ============================================================================
-- Auto Commands
-- Automatic actions for various events
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- General Settings
-- ============================================================================

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Remove whitespace on save
augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = 'TrimWhitespace',
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Restore cursor position
augroup('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = 'RestoreCursor',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
augroup('CloseWithQ', { clear = true })
autocmd('FileType', {
  group = 'CloseWithQ',
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'startuptime',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
  end,
})

-- Auto-create directories when saving files
augroup('AutoCreateDir', { clear = true })
autocmd('BufWritePre', {
  group = 'AutoCreateDir',
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Check if file needs to be reloaded when changed
augroup('CheckTime', { clear = true })
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = 'CheckTime',
  command = 'checktime',
})

-- Resize splits if window got resized
augroup('ResizeSplits', { clear = true })
autocmd('VimResized', {
  group = 'ResizeSplits',
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- ============================================================================
-- File Type Specific
-- ============================================================================

-- Set wrap and spell for text filetypes
augroup('TextFileSettings', { clear = true })
autocmd('FileType', {
  group = 'TextFileSettings',
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Set indentation for specific file types
augroup('FileTypeIndent', { clear = true })
autocmd('FileType', {
  group = 'FileTypeIndent',
  pattern = { 'go' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd('FileType', {
  group = 'FileTypeIndent',
  pattern = { 'python' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
