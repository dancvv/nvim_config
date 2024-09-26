local vscode = require('core.utils').vscode

return {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim',
    cond = not vscode,
    cmd = 'Telescope',
    dependencies = {
      {
        'olimorris/persisted.nvim',
        keys = {
          { '<LEADER>sl', '<CMD>Telescope persisted<CR>', mode = 'n' },
          { '<LEADER>ss', '<CMD>SessionSave<CR>', mode = 'n' },
        },
        config = function()
          require('plugins.configs.persisted')
        end,
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        keys = {
          { '<LEADER>fw', '<CMD>Telescope live_grep_args<CR>', mode = 'n' },
        },
      },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<LEADER>?', '<CMD>Telescope keymaps<CR>', mode = 'n' },
      { '<LEADER>ff', '<CMD>Telescope find_files<CR>', mode = 'n' },
      { '<LEADER>fa', '<CMD>Telescope find_files follow=true no_ignore=true hidden=true<CR>', mode = 'n' },
      { '<LEADER>fb', '<CMD>Telescope buffers<CR>', mode = 'n' },
      { '<LEADER>fr', '<CMD>Telescope resume<CR>', mode = 'n' },
      { '<LEADER>fp', '<CMD>Telescope pickers<CR>', mode = 'n' },
      { '<LEADER>fh', '<CMD>Telescope help_tags<CR>', mode = 'n' },
      { '<LEADER>fl', '<CMD>Telescope live_grep<CR>', mode = 'n' },
    },
    config = function()
      require('plugins.configs.telescope')
    end,
  },
  {
    'echasnovski/mini.files',
    cond = not vscode,
    version = '*',
    keys = {
      {
        '<LEADER>e',
        function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          end
        end,
        mode = 'n',
      },
    },
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not vscode,
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/playground' },
      {
        'RRethy/nvim-treesitter-endwise',
        config = function()
          require('nvim-treesitter.configs').setup({ endwise = { enable = true } })
        end,
      },
      {
        'kevinhwang91/nvim-ufo',
        event = 'BufEnter',
        dependencies = {
          'kevinhwang91/promise-async',
        },
        config = function()
          require('plugins.configs.ufo')
        end,
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = { enable = false },
        keys = {
          {
            '<LEADER>ck',
            function()
              return require('treesitter-context').go_to_context()
            end,
            mode = 'n',
          },
          { '<LEADER>cc', '<CMD>TSContextToggle<CR>', mode = 'n' },
        },
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        opts = {},
      },
    },
    config = function()
      require('plugins.configs.treesitter')
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    cond = not vscode,
    version = 'v2.*',
    opts = {
      open_mapping = [[<c-\>]],
      size = 20,
    },
  },
  {
    "Pocco81/auto-save.nvim",
    cond = not vscode,
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      -- Multi-Cursor https://github.com/mg979/vim-visual-multi/blob/master/doc/vm-mappings.txt
      -- vim.g.VM_leader = "\\"
      vim.g.VM_theme = "purplegray"

      vim.g.VM_maps = {
        -- TODO: fix mappings <C-q> already been used to check project
        -- permanent mappings
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>", -- select some text firstly , then <M-b>

        -- ["Select Cursor Down"] = "<C-S-j>", -- switch upper and lower window with <C-w>jk
        ["Select Cursor Up"] = "<C-S-k>",
        ["Select Cursor Down"] = "<C-S-j>",

        -- ["Start Regex Search"] = "<C-q>/",
        ["Visual All"] = "\\A", --  1. selected some text in visual mode 2. press <C-q>j to select all

        -- buffer mappings
        ["Switch Mode"] = "v",
        ["Skip Region"] = "q",
        ["Remove Region"] = "Q",
        ["Goto Next"] = "}",
        ["Goto Prev"] = "{",

        -- ["Duplicate"] = "<C-q>d",

        ["Tools Menu"] = "\\t",
        ["Case Conversion Menu"] = "C",
        ["Align"] = "\\a",
      }

      -- https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
      vim.g.VM_set_statusline = 0 -- already set via lualine component
    end,
  },
  {
    "tpope/vim-surround"
  }
}
