local function snacks()
  return require('snacks')
end

local function root()
  return require('config.root').get()
end

local function git_root()
  return require('config.root').git()
end

local function warp_image(image, width, height)
  local image_id = (vim.fn.getpid() % 65535) * 256 + 71
  local placement_id = image_id + 1
  local sent = false
  local closed = false
  local dashboard
  local last_pos

  local function send(data)
    if not closed then
      pcall(vim.api.nvim_ui_send, data)
    end
  end

  local function delete_placement()
    send(('\27_Ga=d,d=i,i=%d,p=%d,q=2\27\\'):format(image_id, placement_id))
  end

  local function place()
    vim.schedule(function()
      if
        closed
        or not dashboard
        or not last_pos
        or not vim.api.nvim_win_is_valid(dashboard.win)
      then
        return
      end
      if vim.api.nvim_win_get_tabpage(dashboard.win) ~= vim.api.nvim_get_current_tabpage() then
        delete_placement()
        return
      end
      local win_pos = vim.fn.win_screenpos(dashboard.win)
      local win_width = vim.api.nvim_win_get_width(dashboard.win)
      local placed_width = math.min(width, math.max(1, win_width - 4))
      local placed_height = math.max(1, math.floor((placed_width * height / width) + 0.5))
      local row = win_pos[1] + last_pos[1] - 1
      local col = win_pos[2] + math.max(0, math.floor((win_width - placed_width) / 2))
      delete_placement()
      send(('\27[%d;%dH'):format(row, col))
      send(
        ('\27_Ga=p,i=%d,p=%d,C=1,c=%d,r=%d,q=2\27\\'):format(
          image_id,
          placement_id,
          placed_width,
          placed_height
        )
      )
    end)
  end

  local section = {
    text = ('\n'):rep(height - 1),
    render = function(self, pos)
      dashboard = self
      last_pos = { pos[1], pos[2] }
      if not sent then
        sent = true
        send(
          ('\27_Ga=t,t=f,f=100,i=%d,q=2;%s\27\\'):format(
            image_id,
            vim.base64.encode(vim.fn.fnamemodify(image, ':p'))
          )
        )
        vim.api.nvim_create_autocmd({ 'WinEnter', 'WinResized', 'VimResized', 'TabEnter' }, {
          group = self.augroup,
          callback = place,
        })
        vim.api.nvim_create_autocmd('TabLeave', {
          group = self.augroup,
          callback = delete_placement,
        })
        self.on('Closed', function()
          delete_placement()
          send(('\27_Ga=d,d=i,i=%d,q=2\27\\'):format(image_id))
          closed = true
        end, self.augroup)
      end

      place()
    end,
  }
  return section, delete_placement
end

local function dashboard()
  local image = vim.fn.stdpath('config') .. '/assets/dashboard.png'
  local readable_image = vim.fn.filereadable(image) == 1
  local has_warp_image = readable_image
    and vim.env.TERM_PROGRAM == 'WarpTerminal'
    and not vim.env.TMUX
    and vim.api.nvim_ui_send ~= nil
  local has_chafa_image = readable_image and vim.fn.executable('chafa') == 1
  local image_width = 60
  local image_height = 17
  local image_indent = 0

  local sections = {}
  local hide_image = function() end
  if has_warp_image then
    sections[#sections + 1], hide_image = warp_image(image, image_width, image_height)
  elseif has_chafa_image then
    sections[#sections + 1] = {
      section = 'terminal',
      cmd = table.concat({
        'chafa',
        vim.fn.shellescape(image),
        '--format symbols',
        '--symbols vhalf',
        '--colors full',
        ('--size %dx%d'):format(image_width, image_height),
        '--stretch',
        '--animate off',
        '--probe off',
      }, ' '),
      height = image_height,
      indent = image_indent,
      padding = 1,
      ttl = 3600,
    }
  else
    sections[#sections + 1] = {
      text = {
        { 'NEOVIM', hl = 'SnacksDashboardHeader' },
      },
      align = 'center',
      padding = { 2, 1 },
    }
  end

  local function dashboard_action(action)
    return function()
      hide_image()
      action()
    end
  end

  sections[#sections + 1] = {
    {
      text = {
        { 'WELCOME BACK', hl = 'SnacksDashboardTitle' },
      },
      align = 'center',
      padding = { 1, 1 },
    },
    {
      text = {
        { 'Start small. Stay in flow.', hl = 'Comment' },
      },
      align = 'center',
      padding = 1,
    },
    { section = 'keys', padding = 1 },
    {
      icon = ' ',
      title = 'Recent Files',
      section = 'recent_files',
      limit = 3,
      indent = 2,
      padding = 1,
    },
    { section = 'startup' },
  }

  return {
    enabled = true,
    width = 60,
    pane_gap = 5,
    preset = {
      keys = {
        {
          icon = ' ',
          key = 'f',
          desc = 'Find Files',
          action = dashboard_action(function() Snacks.dashboard.pick('files') end),
        },
        {
          icon = ' ',
          key = 'g',
          desc = 'Global Search',
          action = dashboard_action(function() Snacks.dashboard.pick('live_grep') end),
        },
        {
          icon = ' ',
          key = 'r',
          desc = 'Recent Files',
          action = dashboard_action(function() Snacks.dashboard.pick('oldfiles') end),
        },
        {
          icon = ' ',
          key = 'n',
          desc = 'New File',
          action = dashboard_action(function() vim.cmd('ene | startinsert') end),
        },
        {
          icon = '󰙅 ',
          key = 'e',
          desc = 'File Explorer',
          action = dashboard_action(function() Snacks.explorer() end),
        },
        {
          icon = ' ',
          key = 'c',
          desc = 'Edit Config',
          action = dashboard_action(function()
            Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })
          end),
        },
        {
          icon = '󰒲 ',
          key = 'l',
          desc = 'Plugin Manager',
          action = dashboard_action(function() vim.cmd.Lazy() end),
        },
        {
          icon = ' ',
          key = 'q',
          desc = 'Quit',
          action = dashboard_action(function() vim.cmd.qa() end),
        },
      },
    },
    sections = sections,
  }
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      transparent_background = false,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        mini = true,
        native_lsp = { enabled = true },
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end,
  },

  {
    'folke/snacks.nvim',
    priority = 900,
    event = 'VeryLazy',
    keys = {
      { '<leader><space>', function() snacks().picker.smart({ cwd = root() }) end, desc = 'Smart find' },
      { '<leader>/', function() snacks().picker.grep({ cwd = root() }) end, desc = 'Grep project' },
      { '<leader>,', function() snacks().picker.buffers() end, desc = 'Buffers' },
      { '<leader>ff', function() snacks().picker.files({ cwd = root() }) end, desc = 'Find files' },
      { '<leader>fF', function() snacks().picker.files({ cwd = vim.uv.cwd() }) end, desc = 'Find files cwd' },
      { '<leader>fg', function() snacks().picker.grep({ cwd = root() }) end, desc = 'Grep project' },
      { '<leader>fG', function() snacks().picker.grep({ cwd = vim.uv.cwd() }) end, desc = 'Grep cwd' },
      { '<leader>fb', function() snacks().picker.buffers() end, desc = 'Buffers' },
      { '<leader>fr', function() snacks().picker.recent({ cwd = root() }) end, desc = 'Recent project files' },
      { '<leader>fR', function() snacks().picker.recent() end, desc = 'Recent files' },
      { '<leader>fh', function() snacks().picker.help() end, desc = 'Help' },
      { '<leader>fk', function() snacks().picker.keymaps() end, desc = 'Keymaps' },
      { '<leader>fc', function() snacks().picker.grep_word() end, mode = { 'n', 'x' }, desc = 'Find word' },
      { '<leader>fp', function() snacks().picker.projects() end, desc = 'Projects' },
      { '<leader>e', function() snacks().explorer({ cwd = root() }) end, desc = 'Explorer project' },
      { '<leader>E', function() snacks().explorer({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'Explorer file directory' },
      { '<C-\\>', function() snacks().terminal(nil, { cwd = root() }) end, desc = 'Terminal' },
      { '<leader>tt', function() snacks().terminal(nil, { cwd = root() }) end, desc = 'Terminal' },
      { '<leader>gg', function() snacks().lazygit({ cwd = git_root() }) end, desc = 'LazyGit' },
      { '<leader>gs', function() snacks().picker.git_status({ cwd = git_root() }) end, desc = 'Git status' },
      { '<leader>gl', function() snacks().picker.git_log({ cwd = git_root() }) end, desc = 'Git log' },
      { '<leader>gL', function() snacks().picker.git_log_file() end, desc = 'Git file log' },
      { '<leader>gb', function() snacks().picker.git_branches({ cwd = git_root() }) end, desc = 'Git branches' },
      { '<leader>go', function() snacks().gitbrowse() end, mode = { 'n', 'x' }, desc = 'Open Git URL' },
      { '<leader>un', function() snacks().picker.notifications() end, desc = 'Notification history' },
      { '<leader>uz', function() snacks().zen() end, desc = 'Zen mode' },
      { '<leader>.', function() snacks().scratch() end, desc = 'Scratch buffer' },
      { '<leader>S', function() snacks().scratch.select() end, desc = 'Scratch list' },
    },
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = dashboard(),
      explorer = { enabled = true, replace_netrw = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true, scope = { enabled = true } },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = {
        enabled = true,
        ui_select = true,
        formatters = { file = { filename_first = true, truncate = 1 } },
        win = {
          input = {
            keys = {
              ['<C-j>'] = { 'list_down', mode = { 'i', 'n' } },
              ['<C-k>'] = { 'list_up', mode = { 'i', 'n' } },
              ['<Esc>'] = { 'close', mode = { 'i', 'n' } },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scratch = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' 󰌾' } } },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      delay = 350,
      win = { border = 'rounded' },
      spec = {
        { '<leader>a', group = '+ai' },
        { '<leader>b', group = '+buffer' },
        { '<leader>c', group = '+code' },
        { '<leader>d', group = '+debug/diagnostics' },
        { '<leader>f', group = '+find' },
        { '<leader>g', group = '+git' },
        { '<leader>h', group = '+hunk' },
        { '<leader>m', group = '+multi-cursor' },
        { '<leader>q', group = '+quit/session' },
        { '<leader>r', group = '+request' },
        { '<leader>s', group = '+search' },
        { '<leader>t', group = '+terminal/test' },
        { '<leader>u', group = '+toggle' },
        { '<leader>w', group = '+window' },
        { '<leader>x', group = '+trouble' },
      },
    },
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },
}
