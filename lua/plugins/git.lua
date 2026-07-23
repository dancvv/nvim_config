return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      attach_to_untracked = true,
      current_line_blame = false,
      preview_config = { border = 'rounded' },
      on_attach = function(buffer)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, silent = true, desc = desc })
        end

        map('n', ']h', gs.next_hunk, 'Next hunk')
        map('n', '[h', gs.prev_hunk, 'Previous hunk')
        map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('x', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage hunk')
        map('x', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'Select hunk')
      end,
    },
  },

  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history' },
    },
    opts = {},
  },
}
