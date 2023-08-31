local g = vim.g;
local opt = vim.opt;
local options = {
  wrap = true,
  magic = true,
  number = true,
  undofile = true,
  autoread = true,
  smartcase = true,
  linebreak = true,
  autoindent = true,
  shiftround = true,
  cursorline = true,
  breakindent = true,
  smartindent = true,
  equalalways = true,
  termguicolors = true,
  relativenumber = true,
  backup = false,
  timeout = false,
  showmode = false,
  autochdir = false,
  foldenable = false,
  compatible = false,
  fixendofline = false,
  tabstop = 2,
  foldlevel = 0,
  scrolloff = 2,
  shiftwidth = 2,
  sidescroll = 0,
  softtabstop = 2,
  showtabline = 2,
  sidescrolloff = 2,
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
  showbreak = "󰞔 ",
  cursorlineopt = "number",
  expandtab = vim.bo.filetype ~= "make",
  cinoptions = "l1,N-s,E-s,t0,U1",
  --[[ foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()", ]]
};

for k, v in pairs(options) do
  opt[k] = v;
end

opt.matchpairs:append("<:>");
opt.runtimepath:remove("/usr/share/vim/vimfiles");  -- separate vim plugins from neovim in case vim still in use
vim.cmd.syntax("clear");

g.python_recommended_style = 0;
g.rust_recommended_style = 0;
g.meson_recommended_style = 0;
g.yaml_recommended_style = 0;
g.markdown_recommended_style = 0;
g.loaded_ruby_provider = 0;
g.loaded_perl_provider = 0;
g.loaded_node_provider = 0;
g.bracey_refresh_on_save = 1
