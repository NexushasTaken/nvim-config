local opt = vim.opt
local api = vim.api
local fn = vim.fn
local util = require'utils'
local create_cmd = api.nvim_create_user_command

local function delete_swap()
  for _,dir in ipairs(opt.directory:get()) do
    if dir ~= '.' and dir ~= './' then
      os.execute('rm -rf '..dir)
      print('Delete : '..dir)
    end
  end
end

if opt.swapfile then
  create_cmd('SwapDelete', delete_swap, { nargs = 0 })
end
