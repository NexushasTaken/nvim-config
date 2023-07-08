local fn = vim.fn;
local g = vim.g;
local opt = vim.opt;
local options = {
  magic = true,
  number = true,
  undofile = true,
  autoread = true,
  smartcase = true,
  linebreak = true,
  autoindent = true,
  shiftround = true,
  cursorline = true,
  smartindent = true,
  equalalways = true,
  termguicolors = true,
  relativenumber = true,
  wrap = false,
  backup = false,
  timeout = false,
  showmode = false,
  autochdir = false,
  foldenable = false,
  compatible = false,
  fixendofline = false,
  tabstop = 2,
  scrolloff = 2,
  shiftwidth = 2,
  softtabstop = 2,
  showtabline = 2,
  fillchars = {
    fold = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertright = "┣",
    vertleft = "┫",
    verthoriz = "╋",
  },
  mouse = "",
  belloff = "",
  cursorlineopt = "number",
  expandtab = vim.bo.filetype ~= "make",
  cinoptions = "l1,N-s,E-s,t0,U1",
};

for k, v in pairs(options) do
  vim.opt[k] = v;
end

opt.matchpairs:append("<:>,=:;")
opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
vim.cmd.syntax("clear");

g.python_recommended_style = 0;
g.rust_recommended_style = 0;
g.meson_recommended_style = 0;
g.yaml_recommended_style = 0;
g.markdown_recommended_style = 0;
g.loaded_ruby_provider = 0;
g.loaded_perl_provider = 0;
g.loaded_node_provider = 0;
g.loaded_python3_provider = 0;
