local opt = vim.opt
local api = vim.api
local fn = vim.fn
local create_cmd = api.nvim_create_user_command

if opt.swapfile then
  create_cmd('SwapDelete', function()
    local swapname = fn.swapname(fn.bufname())
    os.execute('rm -rf ' .. swapname)
    print('Deleted ' .. swapname)
  end, { nargs = 0 })
end
