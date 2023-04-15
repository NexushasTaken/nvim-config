local fn = vim.fn
local options = {
  magic = true,
  number = true,
  undofile = true,
  smartcase = true,
  linebreak = true,
  shiftround = true,
  autoread = true,
  autowrite = true,
  autowriteall = true,
  autoindent = true,
  equalalways = true,
  termguicolors = true,
  relativenumber = true,
  cursorline = true,
  foldenable = true,
  digraph = true,
  wrap = false,
  backup = false,
  timeout = false,
  showmode = false,
  autochdir = false,
  compatible = false,
  tabstop = 2,
  scrolloff = 2,
  shiftwidth = 2,
  softtabstop = 2,
  showtabline = 2,
    fillchars = {
    fold = ' ',
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertright = '┣',
    vertleft = '┫',
    verthoriz = '╋',
  },
  shortmess = 'ilmnrxc',
  foldtext = 'v:lua.myFoldText()',
  foldexpr = 'nvim_treesitter#foldexpr()',
  cursorlineopt = 'number',
  foldmethod = 'expr',
  foldlevel = 999999,
  expandtab = fn.tolower(fn.expand'#') ~= 'makefile',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.iskeyword:append'-' -- hyphenated words recognized by searches
-- don't insert the current comment leader automatically
--  for auto-wrapping comments using 'textwidth',
--  hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use

vim.fn.setenv('MANWIDTH', 94)
