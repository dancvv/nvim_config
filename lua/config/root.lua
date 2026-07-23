local M = {}

M.markers = {
  '.git',
  'package.json',
  'pnpm-workspace.yaml',
  'deno.json',
  'pyproject.toml',
  'go.mod',
  'Cargo.toml',
  'pom.xml',
  'build.gradle',
  'Makefile',
  'docker-compose.yml',
  'terraform.tf',
}

local cache = {}

local function path(buf)
  local name = vim.api.nvim_buf_get_name(buf or 0)
  return name ~= '' and vim.fs.normalize(name) or vim.uv.cwd()
end

function M.get(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if cache[buf] then
    return cache[buf]
  end

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    if client.config.root_dir then
      cache[buf] = client.config.root_dir
      return cache[buf]
    end
  end

  local root = vim.fs.root(path(buf), M.markers) or vim.uv.cwd() or vim.fn.getcwd()
  cache[buf] = root
  return root
end

function M.git()
  local root = M.get()
  return vim.fs.root(root, '.git') or root
end

function M.setup()
  vim.api.nvim_create_user_command('NvimRoot', function()
    vim.notify(M.get(), vim.log.levels.INFO, { title = 'Project root' })
  end, { desc = 'Show project root' })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'DirChanged', 'LspAttach' }, {
    group = vim.api.nvim_create_augroup('UserRootCache', { clear = true }),
    callback = function(event)
      if event.buf and event.buf > 0 then
        cache[event.buf] = nil
      else
        cache = {}
      end
    end,
  })
end

return M
