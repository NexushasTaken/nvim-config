local opt = vim.opt
local api = vim.api
local fn = vim.fn
local util = require'utils'
local create_cmd = api.nvim_create_user_command

local function delete_swap()
  local swapname = fn.swapname(fn.bufname())
  os.execute('rm -rf '..swapname)
  print('Deleted '..swapname)
end

if opt.swapfile then
  create_cmd('SwapDelete', delete_swap, { nargs = 0 })
end
