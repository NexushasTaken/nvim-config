local fn = vim.fn;
local g = vim.g;
local opt = vim.opt;
local options = {
  magic = true,
  number = true,
  digraph = true,
  undofile = true,
  autoread = true,
  autowrite = true,
  smartcase = true,
  linebreak = true,
  shiftround = true,
  autoindent = true,
  cursorline = true,
  foldenable = true,
  equalalways = true,
  autowriteall = true,
  termguicolors = true,
  relativenumber = true,
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
  cursorlineopt = "number",
  expandtab = fn.tolower(fn.expand"#") ~= "makefile",
  -- "langmap" is the best feature! (in the context of switching keyboard layouts)
  langmap = "nir;jkl,jkl;nir,NIR;JKL,JKL;NIR",
};

for k, v in pairs(options) do
  vim.opt[k] = v;
end

opt.iskeyword:remove("_")
opt.matchpairs:append("<:>,=:;")
opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
vim.cmd.syntax("clear");

fn.setenv("MANWIDTH", 94);

g.python_recommended_style = 0;
g.rust_recommended_style = 0;
g.meson_recommended_style = 0;
g.yaml_recommended_style = 0;
g.markdown_recommended_style = 0;
g.loaded_ruby_provider = 0;
g.loaded_perl_provider = 0;
g.loaded_node_provider = 0;
g.loaded_python3_provider = 0;
