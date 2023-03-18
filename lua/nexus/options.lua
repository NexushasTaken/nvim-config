local fn = vim.fn
fn.setenv('MANWIDTH', 94)

return {
  {
    true,
    "magic",
    "number",
    "undofile",
    "smartcase",
    "linebreak",
    "shiftround",
    "autoindent",
    "equalalways",
    "termguicolors",
    "relativenumber",
  },
  {
    false,
    "wrap",
    "backup",
    "timeout",
    "showmode",
    "autochdir",
    "compatible",
    "cursorline",
  },
  {
    2,
    "tabstop",
    "scrolloff",
    "shiftwidth",
    "softtabstop",
    "showtabline",
  },
  foldlevel = 999999,
  expandtab = fn.tolower(fn.expand'#') ~= 'makefile',
}
