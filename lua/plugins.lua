local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- plugins list

    if vim.g.vscode then
    --------------------- vscode --------------------
      use{"mg979/vim-visual-multi", cond = function() return not vim.g.vscode end}
      use({ "kylechui/nvim-surround", tag = "*" })
      use("folke/tokyonight.nvim")
      use("ggandor/leap.nvim")

    else
    --------------------- ordinary neovim --------------------
      use("folke/tokyonight.nvim")
      use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"})
      use({'akinsho/bufferline.nvim', tag = "v3.*", requires = {"nvim-tree/nvim-web-devicons", "moll/vim-bbye" }})
      -- 状态栏
      use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
      use("arkav/lualine-lsp-progress")
      use("dracula/vim")
      use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
      -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
      }
      use { "nvim-telescope/telescope-file-browser.nvim" }
      use("nvim-telescope/telescope-project.nvim")
      use { "LinArcX/telescope-env.nvim" }
      use({"Pocco81/auto-save.nvim",config = function()
        require("auto-save").setup { }
          end,
        })

      use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }
      use {"mg979/vim-visual-multi"}
      -- 补全引擎
      use("hrsh7th/nvim-cmp")
      -- snippet 引擎
      use("hrsh7th/vim-vsnip")
      -- 补全源
      use("hrsh7th/cmp-vsnip")
      use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
      use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
      use("hrsh7th/cmp-path") -- { name = 'path' }
      use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

      -- 常见编程语言代码段
      use("rafamadriz/friendly-snippets")
      use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }
      use("bkad/CamelCaseMotion")
      use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
      use({ "kylechui/nvim-surround", tag = "*" })
      -- moving arround cursor
      use("ggandor/leap.nvim")
      --------------------- LSP --------------------
      -- use("williamboman/nvim-lsp-installer")
      use { "williamboman/mason.nvim" }
      use { "williamboman/mason-lspconfig.nvim" }
      -- Lspconfig
      use("neovim/nvim-lspconfig")
      use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
          local db = require("plugin-config.dashboard")
          db()
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
      }
      use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
      use('numToStr/Comment.nvim')
      -- use('ldelossa/nvim-ide')
      use("rcarriga/nvim-notify")
      use("akinsho/toggleterm.nvim")
      use("lewis6991/gitsigns.nvim")
      use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
      use("github/copilot.vim")
      use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
      use { "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons" }
    end
  end,
  -- git proxy through ssh, need to config the ssh key
  config = {
    max_jobs = 32,
    git = {
      default_url_format = "git@github.com:%s"
    }
  }
})

-- automaticall run packer sync command
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync

  augroup end
]])
