return {
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = { { '<leader>-', '<cmd>Oil<cr>', desc = 'Open parent directory' } },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['q'] = 'actions.close',
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      highlight = { backdrop = false },
      modes = { char = { enabled = false } },
    },
    keys = {
      { 's', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' },
      { 'S', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash treesitter' },
      { 'r', function() require('flash').remote() end, mode = 'o', desc = 'Remote Flash' },
      { 'R', function() require('flash').treesitter_search() end, mode = { 'o', 'x' }, desc = 'Treesitter search' },
    },
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace diagnostics' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
    },
  },

  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    opts = { headerMaxWidth = 100 },
    keys = {
      { '<leader>sr', function() require('grug-far').open() end, desc = 'Search and replace' },
      {
        '<leader>sw',
        function()
          require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
        end,
        desc = 'Replace current word',
      },
    },
  },

  {
    'echasnovski/mini.nvim',
    version = false,
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.pairs').setup()
      require('mini.surround').setup()
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile' },
    ft = { 'html', 'javascriptreact', 'typescriptreact', 'vue', 'xml' },
    opts = {},
  },

  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    event = 'VeryLazy',
    config = function()
      local mc = require('multicursor-nvim')
      local map = vim.keymap.set
      mc.setup()

      map({ 'n', 'x' }, '<C-n>', function() mc.matchAddCursor(1) end, { desc = 'Add next match cursor' })
      map({ 'n', 'x' }, '<leader>mn', function() mc.matchAddCursor(1) end, { desc = 'Add next match' })
      map({ 'n', 'x' }, '<leader>mN', function() mc.matchAddCursor(-1) end, { desc = 'Add previous match' })
      map({ 'n', 'x' }, '<leader>ma', mc.matchAllAddCursors, { desc = 'Add all matches' })
      map({ 'n', 'x' }, '<leader>ms', function() mc.matchSkipCursor(1) end, { desc = 'Skip next match' })
      map({ 'n', 'x' }, '<leader>mj', function() mc.lineAddCursor(1) end, { desc = 'Add cursor below' })
      map({ 'n', 'x' }, '<leader>mk', function() mc.lineAddCursor(-1) end, { desc = 'Add cursor above' })
      map({ 'n', 'x' }, '<C-Down>', function() mc.lineAddCursor(1) end, { desc = 'Add cursor below' })
      map({ 'n', 'x' }, '<leader>mt', mc.toggleCursor, { desc = 'Toggle cursor' })
      map('n', '<leader>mr', mc.restoreCursors, { desc = 'Restore cursors' })
      map('n', '<leader>m=', mc.alignCursors, { desc = 'Align cursors' })
      map('n', '<C-LeftMouse>', mc.handleMouse)
      map('n', '<C-LeftDrag>', mc.handleMouseDrag)
      map('n', '<C-LeftRelease>', mc.handleMouseRelease)

      mc.addKeymapLayer(function(layer)
        layer({ 'n', 'x' }, '<Left>', mc.prevCursor)
        layer({ 'n', 'x' }, '<Right>', mc.nextCursor)
        layer({ 'n', 'x' }, '<leader>mx', mc.deleteCursor)
        layer('n', '<Esc>', function()
          if mc.cursorsEnabled() then
            mc.clearCursors()
          else
            mc.enableCursors()
          end
        end)
      end)
    end,
  },
}
