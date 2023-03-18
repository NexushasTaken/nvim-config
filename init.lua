local data_dir = vim.fn.stdpath("data")
local lazypath = data_dir .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require'nexus'
require'lazy'.setup(require'nexus.plugins', {
  lockfile = data_dir .. '/lazy-lock.json',
})
