local M = {}

local function load_module(mod)
  if type(mod) == 'string' then
    mod = require(mod)
  end
  return mod
end

M.set_opts = function(opt)
  opt = load_module(opt)
  for i, x in pairs(opt) do
    local i_type = type(i)
    if i_type == 'number' then
      for val = 2, #x do
        vim.opt[x[val]] = x[1]
      end
    elseif i_type == 'string' then
      vim.opt[i] = x
    else
      vim.notify('set_opts : Unhandled type '..i_type, vim.log.levels.ERROR)
    end
  end
end

M.set_vars = function(vars)
  vars = load_module(vars)
  for i, x in pairs(vars) do
    for k, v in pairs(x) do
      vim[i][k] = v
    end
  end
end

M.set_env_vars = function(envs)
  envs = load_module(envs)
  for k, v in pairs(envs) do
    vim[k] = v
  end
end

M.set_mapping = function(maps)
  maps = load_module(maps)
  for _, m in pairs(maps) do
    local opts = m[4] or {}
    opts['noremap'] = true
    vim.keymap.set(m[1], m[2], m[3], opts)
  end
end

M.cwd = function(sub, char)
  local cwd = vim.fn.getcwd()
  if sub then
    cwd = cwd:gsub('/', char or '_')
  end
  return cwd
end

return M
