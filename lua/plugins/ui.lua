-- ============================================================================
-- UI Plugins
-- Statusline, bufferline, colorscheme, icons, etc.
-- ============================================================================

return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true,
        strict = true,
      })
    end,
  },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          notify = true,
          mini = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1, -- 0: just filename, 1: relative path, 2: absolute path
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
              },
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close unpinned buffers" },
      { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    },
    config = function()
      local icons = require("ui.icons")

      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = icons.diagnostics.error
            if level:match("warn") then
              icon = icons.diagnostics.warn
            elseif level:match("info") then
              icon = icons.diagnostics.info
            elseif level:match("hint") then
              icon = icons.diagnostics.hint
            end
            return " " .. icon .. " " .. count
          end,
          modified_icon = icons.bufferline.modified,
          close_icon = icons.bufferline.buffer_close,
          left_trunc_marker = icons.ui.arrow_left,
          right_trunc_marker = icons.ui.arrow_right,
          offsets = {
            {
              filetype = "neo-tree",
              text = "  File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Better UI components
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        default_prompt = "➤ ",
        win_options = {
          winblend = 0,
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
      },
    },
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss notifications",
      },
    },
    config = function()
      local notify = require("notify")
      notify.setup({
        timeout = 2000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        background_colour = "#000000",
        stages = "fade",
        render = "compact",
        level = vim.log.levels.WARN, -- Only show warnings and errors
        minimum_width = 30,
        top_down = true,
      })

      -- Override vim.notify but filter out LSP progress messages
      local orig_notify = notify
      vim.notify = function(msg, level, opts)
        -- Filter out common noisy messages
        if msg and type(msg) == "string" then
          -- Skip LSP progress messages
          if msg:match("^%s*$") or msg:match("^LSP") or msg:match("formatting") then
            return
          end
          -- Skip auto-save messages
          if msg:match("AutoSave") or msg:match("auto%-save") then
            return
          end
          -- Skip mason messages
          if msg:match("mason") or msg:match("Mason") then
            return
          end
        end
        orig_notify(msg, level, opts)
      end
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local icons = require("ui.icons")

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
        dashboard.button("f", icons.alpha.find_file .. "Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", icons.alpha.new_file .. "New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", icons.alpha.recent_files .. "Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", icons.alpha.find_text .. "Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", icons.alpha.config .. "Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", icons.alpha.lazy .. "Lazy", ":Lazy<CR>"),
        dashboard.button("q", icons.alpha.quit .. "Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)
    end,
  },

  -- Which-key (shows keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+diagnostics" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>s"] = { name = "+split" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>x"] = { name = "+trouble" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
