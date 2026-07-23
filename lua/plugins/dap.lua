local js_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }

return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug continue' },
      { '<F10>', function() require('dap').step_over() end, desc = 'Debug step over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'Debug step into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'Debug step out' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      {
        '<leader>dB',
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = 'Conditional breakpoint',
      },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug continue' },
      { '<leader>dr', function() require('dap').repl.open() end, desc = 'Debug REPL' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Run last debug session' },
      { '<leader>dq', function() require('dap').terminate() end, desc = 'Terminate debug session' },
    },
    config = function()
      local dap = require('dap')
      local mason = vim.fn.stdpath('data') .. '/mason'

      vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapStopped', { text = '>', texthl = 'DiagnosticInfo' })

      local codelldb = mason .. '/packages/codelldb/extension/adapter/codelldb'
      if vim.fn.executable(codelldb) == 1 then
        dap.adapters.codelldb = {
          type = 'server',
          port = '${port}',
          executable = { command = codelldb, args = { '--port', '${port}' } },
        }
        for _, language in ipairs({ 'c', 'cpp', 'rust' }) do
          dap.configurations[language] = {
            {
              name = 'Launch executable',
              type = 'codelldb',
              request = 'launch',
              program = function()
                return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
            },
          }
        end
      end

      if vim.fn.executable(mason .. '/bin/js-debug-adapter') == 1 then
        dap.adapters['pwa-node'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = { command = mason .. '/bin/js-debug-adapter', args = { '${port}' } },
        }
        for _, language in ipairs(js_filetypes) do
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch current file',
              program = '${file}',
              cwd = '${workspaceFolder}',
              sourceMaps = true,
            },
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach to Node process',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
              sourceMaps = true,
            },
          }
        end
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    keys = { { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug UI' } },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup({ floating = { border = 'rounded' } })
      dap.listeners.after.event_initialized.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end
    end,
  },

  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = { 'mfussenegger/nvim-dap' },
    opts = {},
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local python = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
      if vim.fn.executable(python) == 0 then
        python = vim.fn.exepath('python3')
      end
      require('dap-python').setup(python)
    end,
  },
}
