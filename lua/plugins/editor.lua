-- ============================================================================
-- Editor Enhancement Plugins
-- File explorer, fuzzy finder, comments, etc.
-- ============================================================================

local not_vscode = not vim.g.vscode -- VSCode provides explorer, search, diagnostics

return {
  -- Auto save
  {
    'okuuva/auto-save.nvim',
    cond = not_vscode, -- VSCode auto-saves natively
    event = { 'InsertLeave', 'TextChanged' },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { 'BufLeave', 'FocusLost' },
        defer_save = { 'InsertLeave', 'TextChanged' },
        cancel_deferred_save = { 'InsertEnter' },
      },
      condition = function(buf)
        local fn = vim.fn
        local utils = require('auto-save.utils.data')

        -- Don't save for special buffers
        if
          fn.getbufvar(buf, '&modifiable') == 1
          and utils.not_in(fn.getbufvar(buf, '&filetype'), {
            'oil',
          })
        then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 1000,
    },
  },

  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    cond = not_vscode,
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file explorer' },
      { '<leader>o', '<cmd>NvimTreeFocus<cr>', desc = 'Focus file explorer' },
      { '<leader>nf', '<cmd>NvimTreeFindFile<cr>', desc = 'Find current file in tree' },
    },
    config = function()
      local icons = require('ui.icons')

      -- Disable netrw at the very start
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- 自定义nvim-tree的键映射
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- 默认键位
        api.config.mappings.default_on_attach(bufnr)

        -- 添加自定义键位：Ctrl+j/k 快速移动
        vim.keymap.set('n', '<C-j>', '5j', opts('Move down 5 lines'))
        vim.keymap.set('n', '<C-k>', '5k', opts('Move up 5 lines'))
      end

      require('nvim-tree').setup({
        -- Automatically close the tree when it's the last window
        auto_reload_on_write = true,
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        on_attach = on_attach,
        view = {
          adaptive_size = false,
          side = 'left',
          width = 35,
          preserve_window_proportions = true,
        },
        git = {
          enable = true,
          ignore = false,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          open_file = {
            resize_window = true,
            quit_on_open = false,
          },
        },
        renderer = {
          root_folder_label = ':~:s?$?/..?',
          highlight_git = true,
          highlight_opened_files = 'none',
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = icons.file_icons.default,
              symlink = icons.file_icons.symlink or '',
              folder = {
                default = icons.file_icons.folder_closed,
                open = icons.file_icons.folder_open,
                empty = icons.file_icons.folder_empty,
                empty_open = icons.file_icons.folder_empty_open,
                symlink = icons.file_icons.folder_symlink or '',
                symlink_open = icons.file_icons.folder_symlink_open or '',
                arrow_open = icons.file_icons.folder_arrow_open,
                arrow_closed = icons.file_icons.folder_arrow_closed,
              },
              git = {
                unstaged = icons.git_icons.unstaged,
                staged = icons.git_icons.staged,
                unmerged = icons.git_icons.unmerged,
                renamed = icons.git_icons.renamed,
                untracked = icons.git_icons.untracked,
                deleted = icons.git_icons.deleted,
                ignored = icons.git_icons.ignored,
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
          custom = { 'node_modules', '^\\.git$', '^\\.DS_Store$' },
        },
      })
    end,
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    cond = not_vscode,
    cmd = 'Telescope',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
      { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Find string under cursor' },
      { '<leader>dl', '<cmd>Telescope diagnostics<cr>', desc = 'List diagnostics' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local icons = require('ui.icons')

      telescope.setup({
        defaults = {
          prompt_prefix = icons.telescope.prompt_prefix,
          selection_caret = icons.telescope.selection_caret,
          entry_prefix = icons.telescope.entry_prefix,
          path_display = { 'smart' },
          file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/' },
          mappings = {
            i = {
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-c>'] = actions.close,
              ['<Down>'] = actions.move_selection_next,
              ['<Up>'] = actions.move_selection_previous,
              ['<CR>'] = actions.select_default,
              ['<C-x>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
            },
            n = {
              ['<esc>'] = actions.close,
              ['<CR>'] = actions.select_default,
              ['<C-x>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,
              ['H'] = actions.move_to_top,
              ['M'] = actions.move_to_middle,
              ['L'] = actions.move_to_bottom,
              ['gg'] = actions.move_to_top,
              ['G'] = actions.move_to_bottom,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
            },
          },
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
            previewer = false,
          },
        },
      })

      telescope.load_extension('fzf')
    end,
  },

  -- NOTE: Comment.nvim removed - Neovim 0.10+ has built-in gc/gcc comment operator
  -- Use gcc (line), gc{motion}, or gc in visual mode

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          javascript = { 'template_string' },
        },
        disable_filetype = { 'TelescopePrompt', 'vim' },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment',
        },
      })

      -- NOTE: nvim-cmp integration removed (replaced by blink.cmp)
      -- blink.cmp handles auto-brackets natively via completion.accept.auto_brackets
    end,
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  -- Flash (quick jump/search)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },

  -- Trouble (better diagnostics) - v3 API
  {
    'folke/trouble.nvim',
    cond = not_vscode,
    cmd = { 'Trouble' },
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble quickfix toggle<cr>', desc = 'Quickfix list (Trouble)' },
    },
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    cond = not_vscode,
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
      { '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
    },
  },
}
