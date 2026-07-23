return {
  {
    'folke/sidekick.nvim',
    cmd = 'Sidekick',
    opts = {},
    keys = {
      { '<C-.>', function() require('sidekick.cli').focus() end, mode = { 'n', 'x', 'i', 't' }, desc = 'Focus AI agent' },
      { '<leader>aa', function() require('sidekick.cli').toggle() end, desc = 'Toggle AI agent' },
      {
        '<leader>as',
        function() require('sidekick.cli').select({ filter = { installed = true } }) end,
        desc = 'Select installed agent',
      },
      { '<leader>ad', function() require('sidekick.cli').close() end, desc = 'Close agent session' },
      {
        '<leader>at',
        function() require('sidekick.cli').send({ msg = '{this}' }) end,
        mode = { 'n', 'x' },
        desc = 'Send current context',
      },
      { '<leader>af', function() require('sidekick.cli').send({ msg = '{file}' }) end, desc = 'Send file' },
      {
        '<leader>av',
        function() require('sidekick.cli').send({ msg = '{selection}' }) end,
        mode = 'x',
        desc = 'Send selection',
      },
      {
        '<leader>ap',
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'x' },
        desc = 'AI prompt library',
      },
      {
        '<leader>ac',
        function() require('sidekick.cli').toggle({ name = 'codex', focus = true }) end,
        desc = 'Toggle Codex',
      },
      {
        '<leader>aC',
        function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end,
        desc = 'Toggle Claude',
      },
      {
        '<leader>ag',
        function() require('sidekick.cli').toggle({ name = 'gemini', focus = true }) end,
        desc = 'Toggle Gemini',
      },
      { '<leader>aL', '<cmd>CopilotToggle<cr>', desc = 'Toggle Copilot LSP' },
      {
        '<leader>an',
        function() require('sidekick').nes_jump_or_apply() end,
        mode = { 'n', 'i' },
        desc = 'Apply Copilot next edit',
      },
      { '<leader>au', '<cmd>Sidekick nes update<cr>', desc = 'Request Copilot next edit' },
      { '<leader>aT', '<cmd>Sidekick nes toggle<cr>', desc = 'Toggle Copilot next edits' },
    },
  },
}
