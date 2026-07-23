return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    cmd = 'Kulala',
    keys = {
      { '<leader>rr', function() require('kulala').run() end, desc = 'Run HTTP request' },
      { '<leader>ra', function() require('kulala').run_all() end, desc = 'Run all HTTP requests' },
      { '<leader>ri', function() require('kulala').inspect() end, desc = 'Inspect HTTP request' },
      { '<leader>rs', function() require('kulala').scratchpad() end, desc = 'HTTP scratchpad' },
    },
    opts = {
      global_keymaps = false,
      kulala_keymaps = false,
    },
  },

  {
    'tpope/vim-dadbod',
    cmd = 'DB',
  },

  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    keys = {
      { '<leader>DD', '<cmd>DBUIToggle<cr>', desc = 'Database UI' },
      { '<leader>Da', '<cmd>DBUIAddConnection<cr>', desc = 'Add database connection' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/dadbod-ui'
      vim.g.db_ui_execute_on_save = 0
    end,
  },

  {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'mysql', 'plsql' },
  },
}
