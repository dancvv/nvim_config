local M = {}

local checks = {
  { 'git', true },
  { 'rg', true },
  { 'fd', false },
  { 'node', true },
  { 'npm', true },
  { 'go', false },
  { 'python3', false },
  { 'java', false },
  { 'rustc', false },
  { 'docker', false },
  { 'codex', false },
  { 'claude', false },
  { 'gemini', false },
  { 'copilot', false },
}

function M.setup()
  vim.api.nvim_create_user_command('NvimConfig', function()
    local ok, snacks = pcall(require, 'snacks')
    if ok then
      snacks.picker.files({ cwd = vim.fn.stdpath('config') })
    else
      vim.cmd.edit(vim.env.MYVIMRC)
    end
  end, { desc = 'Open Neovim config' })

  vim.api.nvim_create_user_command('NvimHealth', function()
    pcall(function()
      require('lazy').load({
        plugins = {
          'blink.cmp',
          'conform.nvim',
          'mason-lspconfig.nvim',
          'mason.nvim',
          'nvim-treesitter',
        },
      })
    end)
    vim.cmd('checkhealth lazy mason vim.lsp nvim-treesitter blink.cmp conform')
  end, { desc = 'Run Neovim configuration health checks' })

  vim.api.nvim_create_user_command('NvimUpdate', function()
    vim.cmd('Lazy sync')
  end, { desc = 'Update and clean plugins' })

  vim.api.nvim_create_user_command('NvimDoctor', function()
    local version = vim.version()
    local lines = { ('Neovim %d.%d.%d'):format(version.major, version.minor, version.patch), '' }
    for _, item in ipairs(checks) do
      local executable, required = item[1], item[2]
      local found = vim.fn.executable(executable) == 1
      local state = found and 'OK' or (required and 'MISSING (required)' or 'missing (optional)')
      lines[#lines + 1] = ('%-12s %s'):format(executable, state)
    end
    vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO, { title = 'Nvim doctor' })
  end, { desc = 'Check external executables' })
end

return M
