local parsers = {
  'bash',
  'c',
  'comment',
  'cpp',
  'css',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'graphql',
  'hcl',
  'html',
  'java',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'prisma',
  'python',
  'query',
  'regex',
  'rust',
  'scss',
  'sql',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'xml',
  'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      vim.api.nvim_create_user_command('TSInstallConfigured', function()
        require('nvim-treesitter').install(parsers):wait(300000)
      end, { desc = 'Install configured Treesitter parsers' })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
        callback = function(event)
          local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
          if language and pcall(vim.treesitter.start, event.buf, language) then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  {
    'folke/ts-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      snippets = { preset = 'default' },
      keymap = {
        preset = 'enter',
        ['<Tab>'] = {
          'snippet_forward',
          function()
            local ok, sidekick = pcall(require, 'sidekick')
            return ok and sidekick.nes_jump_or_apply()
          end,
          function()
            return vim.lsp.inline_completion.get()
          end,
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          window = { border = 'rounded' },
        },
        ghost_text = { enabled = false },
        menu = {
          border = 'rounded',
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
      },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      cmdline = {
        enabled = true,
        keymap = { preset = 'cmdline' },
        completion = { menu = { auto_show = true } },
      },
      signature = { enabled = true, window = { border = 'rounded' } },
    },
    opts_extend = { 'sources.default' },
  },
}
