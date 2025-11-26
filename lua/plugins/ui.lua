-- ============================================================================
-- UI Plugins
-- Statusline, bufferline, colorscheme, icons, etc.
-- ============================================================================

return {
  -- Icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function()
      require('nvim-web-devicons').setup({
        override = {},
        default = true,
        strict = true,
      })
    end,
  },

  -- Colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          mini = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        },
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            {
              'filename',
              path = 1, -- 0: just filename, 1: relative path, 2: absolute path
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = '[No Name]',
              },
            },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = 'Pin buffer' },
      { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Close unpinned buffers' },
      { '[b', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
      { ']b', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
    },
    config = function()
      local icons = require('ui.icons')

      require('bufferline').setup({
        options = {
          mode = 'buffers',
          separator_style = 'thin',
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level)
            local icon = icons.diagnostics.error
            if level:match('warn') then
              icon = icons.diagnostics.warn
            elseif level:match('info') then
              icon = icons.diagnostics.info
            elseif level:match('hint') then
              icon = icons.diagnostics.hint
            end
            return ' ' .. icon .. ' ' .. count
          end,
          modified_icon = icons.bufferline.modified,
          close_icon = icons.bufferline.buffer_close,
          left_trunc_marker = icons.ui.arrow_left,
          right_trunc_marker = icons.ui.arrow_right,
          offsets = {
            {
              filetype = 'neo-tree',
              text = '  File Explorer',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
        },
      })
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
  },

  -- Better UI components
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        enabled = true,
        default_prompt = '➤ ',
        win_options = {
          winblend = 0,
        },
      },
      select = {
        enabled = true,
        backend = { 'telescope', 'builtin' },
      },
    },
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      local icons = require('ui.icons')

      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[                                                    ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', icons.alpha.find_file .. 'Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', icons.alpha.new_file .. 'New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', icons.alpha.recent_files .. 'Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', icons.alpha.find_text .. 'Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', icons.alpha.config .. 'Config', ':e $MYVIMRC <CR>'),
        dashboard.button('l', icons.alpha.lazy .. 'Lazy', ':Lazy<CR>'),
        dashboard.button('q', icons.alpha.quit .. 'Quit', ':qa<CR>'),
      }

      -- 设置各部分之间的间距
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'

      -- 计算居中位置
      local header_padding = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.25) })
      dashboard.section.header.opts.position = 'center'
      dashboard.section.buttons.opts.position = 'center'

      -- 设置布局
      dashboard.config.layout = {
        { type = 'padding', val = header_padding },
        dashboard.section.header,
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        { type = 'padding', val = 1 },
      }

      -- 设置选项
      dashboard.config.opts.noautocmd = true

      alpha.setup(dashboard.config)
    end,
  },

  -- Which-key (shows keybindings)
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      preset = 'modern',
      delay = 0, -- 立即显示，不等待
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false, -- 禁用操作符的 which-key（v, d, y 等）
          motions = false, -- 禁用动作的 which-key
          text_objects = false, -- 禁用文本对象的 which-key
          windows = true, -- 保留窗口命令
          nav = true, -- 保留导航
          z = true, -- 保留 z 命令
          g = true, -- 保留 g 命令
        },
      },
      win = {
        border = 'rounded',
        padding = { 1, 2 },
      },
      triggers = {
        { '<leader>', mode = { 'n', 'v' } }, -- 只监听 leader 键
        { 'g', mode = { 'n', 'v' } },
        { ']', mode = { 'n', 'v' } },
        { '[', mode = { 'n', 'v' } },
      },
      spec = {
        { 'g', group = '+goto' },
        { ']', group = '+next' },
        { '[', group = '+prev' },
        { '<leader>b', group = '+buffer' },
        { '<leader>c', group = '+code' },
        { '<leader>d', group = '+diagnostics' },
        { '<leader>f', group = '+find' },
        { '<leader>g', group = '+git' },
        { '<leader>h', group = '+hunk' },
        { '<leader>q', group = '+session' },
        { '<leader>s', group = '+split' },
        { '<leader>t', group = '+terminal' },
        { '<leader>u', group = '+ui' },
        { '<leader>x', group = '+trouble' },
      },
    },
  },
}
