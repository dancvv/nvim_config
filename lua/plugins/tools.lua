-- ============================================================================
-- Tool Plugins
-- Terminal, session management, etc.
-- ============================================================================

return {
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        elseif term.direction == "float" then
          return 20
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 0,
        row = function()
          return math.floor(vim.o.lines * 0.1)
        end,
        col = function()
          return math.floor(vim.o.columns * 0.1)
        end,
      },
      winbar = {
        enabled = false,
      },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = "rounded",
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = vim.opt.sessionoptions:get(),
    },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't save current session",
      },
    },
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        silent_chdir = true,
        scope_chdir = "global",
      })

      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find projects" },
    },
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "kj" },
        timeout = 200,
        clear_empty_lines = false,
        keys = "<Esc>",
      })
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      })
    end,
  },

  -- Highlight colors
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
      },
    },
  },
}
