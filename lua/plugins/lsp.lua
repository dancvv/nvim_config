local servers = {
  'basedpyright',
  'bashls',
  'clangd',
  'copilot',
  'cssls',
  'docker_compose_language_service',
  'dockerls',
  'emmet_language_server',
  'eslint',
  'gopls',
  'html',
  'jdtls',
  'jsonls',
  'lua_ls',
  'marksman',
  'prismals',
  'ruff',
  'rust_analyzer',
  'sqls',
  'tailwindcss',
  'taplo',
  'terraformls',
  'vtsls',
  'vue_ls',
  'yamlls',
}

local automatic_servers = {}
for _, server in ipairs(servers) do
  if server ~= 'copilot' then
    automatic_servers[#automatic_servers + 1] = server
  end
end

local tools = {
  'actionlint',
  'clang-format',
  'codelldb',
  'debugpy',
  'delve',
  'eslint_d',
  'gofumpt',
  'goimports',
  'google-java-format',
  'hadolint',
  'js-debug-adapter',
  'markdownlint-cli2',
  'prettier',
  'prettierd',
  'shellcheck',
  'shfmt',
  'sqlfluff',
  'stylua',
  'tree-sitter-cli',
}

local function setup_copilot_commands()
  local function set_copilot(enabled)
    if enabled then
      require('lazy').load({ plugins = { 'sidekick.nvim' } })
    end
    vim.lsp.enable('copilot', enabled)
    vim.notify('Copilot LSP: ' .. (enabled and 'on' or 'off'), vim.log.levels.INFO)
  end

  vim.api.nvim_create_user_command('CopilotOn', function()
    set_copilot(true)
  end, { desc = 'Enable Copilot for this Neovim session' })

  vim.api.nvim_create_user_command('CopilotOff', function()
    set_copilot(false)
  end, { desc = 'Disable Copilot and stop its clients' })

  vim.api.nvim_create_user_command('CopilotToggle', function()
    set_copilot(not vim.lsp.is_enabled('copilot'))
  end, { desc = 'Toggle Copilot for this Neovim session' })
end

local function picker(method, fallback)
  return function()
    local ok, snacks = pcall(require, 'snacks')
    if ok and snacks.picker[method] then
      snacks.picker[method]()
    else
      fallback()
    end
  end
end

local function setup_lsp_keymaps()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
    callback = function(event)
      local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
      end

      map('n', 'gd', picker('lsp_definitions', vim.lsp.buf.definition), 'Go to definition')
      map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
      map('n', 'gi', picker('lsp_implementations', vim.lsp.buf.implementation), 'Go to implementation')
      map('n', 'gr', picker('lsp_references', vim.lsp.buf.references), 'Go to references')
      map('n', 'gy', picker('lsp_type_definitions', vim.lsp.buf.type_definition), 'Go to type definition')
      map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
      map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
      map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
      map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
      map('n', '<leader>co', function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
        })
      end, 'Organize imports')
      map('n', '<leader>cF', function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { 'source.fixAll' }, diagnostics = {} },
        })
      end, 'Fix all')
      map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Previous diagnostic')
      map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
      map('n', '<leader>df', vim.diagnostic.open_float, 'Line diagnostics')
      map('n', '<leader>dl', picker('diagnostics', vim.diagnostic.setqflist), 'Diagnostics')
      map('n', '<leader>ds', picker('lsp_symbols', vim.lsp.buf.document_symbol), 'Document symbols')
      map('n', '<leader>ws', picker('lsp_workspace_symbols', vim.lsp.buf.workspace_symbol), 'Workspace symbols')

      local inlay_method = vim.lsp.protocol.Methods.textDocument_inlayHint
      if client:supports_method(inlay_method, event.buf) then
        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        map('n', '<leader>uh', function()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
          vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
        end, 'Toggle inlay hints')
      end

      local inline_method = vim.lsp.protocol.Methods.textDocument_inlineCompletion
      if client:supports_method(inline_method, event.buf) then
        vim.lsp.inline_completion.enable(true, { bufnr = event.buf })
        map('i', '<C-f>', vim.lsp.inline_completion.get, 'Accept inline completion')
        map('i', '<C-g>', vim.lsp.inline_completion.select, 'Next inline completion')
      end
    end,
  })
end

return {
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'CopilotOn', 'CopilotOff', 'CopilotToggle' },
    dependencies = {
      {
        'mason-org/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate', 'MasonLog' },
        build = ':MasonUpdate',
        keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
        opts = { ui = { border = 'rounded' } },
      },
      'neovim/nvim-lspconfig',
      'saghen/blink.cmp',
      'b0o/schemastore.nvim',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
      },
    },
    opts = {
      ensure_installed = servers,
      automatic_enable = automatic_servers,
    },
    config = function(_, opts)
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })

      vim.diagnostic.config({
        virtual_text = { spacing = 4, source = 'if_many' },
        virtual_lines = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.INFO] = 'I',
            [vim.diagnostic.severity.HINT] = 'H',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'always' },
      })

      local vue_path = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }

      vim.lsp.config('vtsls', {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'vue',
        },
        root_dir = function(bufnr, on_dir)
          local project = vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' })
          local deno = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })
          if not deno or (project and #project > #deno) then
            on_dir(project or vim.fn.getcwd())
          end
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            preferences = { includePackageJsonAutoImports = 'on' },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = { completion = { enableServerSideFuzzyMatch = true } },
            tsserver = { globalPlugins = { vue_plugin } },
          },
        },
      })

      vim.lsp.config('vue_ls', { init_options = { vue = { hybridMode = true } } })
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            analyses = { nilness = true, shadow = true, unusedparams = true, unusedwrite = true, useany = true },
            completeUnimported = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            hint = { enable = true },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            analysis = {
              autoImportCompletions = true,
              diagnosticMode = 'openFilesOnly',
              typeCheckingMode = 'standard',
            },
          },
        },
      })
      local jdtls_java_home = vim.fn.expand('~/.sdkman/candidates/java/21.0.11-zulu')
      if vim.fn.executable(jdtls_java_home .. '/bin/java') == 1 then
        vim.lsp.config('jdtls', { cmd_env = { JAVA_HOME = jdtls_java_home } })
      end
      vim.lsp.config('jsonls', {
        settings = { json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } } },
      })
      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = '' },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      })
      vim.lsp.config('eslint', { settings = { workingDirectories = { mode = 'auto' } } })
      vim.lsp.config('copilot', { settings = { telemetry = { telemetryLevel = 'off' } } })

      setup_lsp_keymaps()
      setup_copilot_commands()
      require('mason-lspconfig').setup(opts)
    end,
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = { 'mason-org/mason.nvim' },
    cmd = {
      'MasonToolsInstall',
      'MasonToolsInstallSync',
      'MasonToolsUpdate',
      'MasonToolsUpdateSync',
      'MasonToolsClean',
    },
    keys = {
      { '<leader>cI', '<cmd>MasonToolsInstall<cr>', desc = 'Install developer tools' },
      { '<leader>cU', '<cmd>MasonToolsUpdate<cr>', desc = 'Update developer tools' },
    },
    opts = {
      ensure_installed = tools,
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    },
  },

  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    init = function()
      vim.g.autoformat = true
    end,
    keys = {
      {
        '<leader>fm',
        function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
        mode = { 'n', 'x' },
        desc = 'Format',
      },
      {
        '<leader>uf',
        function()
          vim.g.autoformat = not vim.g.autoformat
          vim.notify('Autoformat: ' .. (vim.g.autoformat and 'on' or 'off'))
        end,
        desc = 'Toggle autoformat',
      },
    },
    opts = {
      default_format_opts = { timeout_ms = 3000, lsp_format = 'fallback' },
      format_on_save = function(bufnr)
        if vim.g.autoformat and vim.bo[bufnr].buftype == '' then
          return { timeout_ms = 3000, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        graphql = { 'prettierd', 'prettier', stop_after_first = true },
        go = { 'goimports', 'gofumpt' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        java = { 'google-java-format' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        sql = { 'sqlfluff' },
        terraform = { 'terraform_fmt' },
        hcl = { 'terraform_fmt' },
        toml = { 'taplo' },
      },
    },
  },

  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        dockerfile = { 'hadolint' },
        markdown = { 'markdownlint-cli2' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('UserLint', { clear = true }),
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })
    end,
  },
}
