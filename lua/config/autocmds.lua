local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.filetype.add({
  extension = {
    env = 'dotenv',
    http = 'http',
    rest = 'http',
    tf = 'terraform',
    tfvars = 'terraform',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['.env.local'] = 'dotenv',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
  },
  pattern = {
    ['.*%.env%..*'] = 'dotenv',
    ['.*Dockerfile.*'] = 'dockerfile',
  },
})

autocmd('TextYankPost', {
  group = augroup('UserYankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

autocmd('BufReadPost', {
  group = augroup('UserRestoreCursor', { clear = true }),
  callback = function(event)
    if vim.bo[event.buf].filetype == 'gitcommit' then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(event.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd('BufWritePre', {
  group = augroup('UserCreateDirectory', { clear = true }),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(event.match, ':p:h'), 'p')
  end,
})

autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('UserCheckTime', { clear = true }),
  command = 'checktime',
})

autocmd('FileType', {
  group = augroup('UserFormatOptions', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

autocmd('FileType', {
  group = augroup('UserCloseWithQ', { clear = true }),
  pattern = { 'checkhealth', 'help', 'lspinfo', 'man', 'notify', 'qf', 'startuptime' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

autocmd('FileType', {
  group = augroup('UserTextFiles', { clear = true }),
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

autocmd('FileType', {
  group = augroup('UserLanguageIndent', { clear = true }),
  pattern = { 'go', 'gomod', 'gosum', 'gotmpl', 'make' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd('FileType', {
  group = 'UserLanguageIndent',
  pattern = { 'python' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
