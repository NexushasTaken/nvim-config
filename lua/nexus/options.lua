local fn = vim.fn

function myFoldText()
  local v = vim.v
  local line = fn.getline(v.foldstart)
  local length = tostring(v.foldend - v.foldstart) .. ' lines: '
  local level = ' [' .. tostring(v.foldlevel) .. '] '
  return level  .. length  .. line
end

-- if value in the table is an array, arr[1] will be the value of all options after it arr[2..]
return {
  {
    true,
    'magic',
    'number',
    'undofile',
    'smartcase',
    'linebreak',
    'shiftround',
    'autoread',
    'autowrite',
    'autowriteall',
    'autoindent',
    'equalalways',
    'termguicolors',
    'relativenumber',
    'cursorline',
    'foldenable',
    'digraph',
  },
  {
    false,
    'wrap',
    'backup',
    'timeout',
    'showmode',
    'autochdir',
    'compatible',
  },
  {
    2,
    'tabstop',
    'scrolloff',
    'shiftwidth',
    'softtabstop',
    'showtabline',
  },
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
  foldtext = 'v:lua.myFoldText()',
  foldexpr = 'nvim_treesitter#foldexpr()',
  cursorlineopt = 'number',
  foldmethod = 'expr',
  foldlevel = 999999,
  expandtab = fn.tolower(fn.expand'#') ~= 'makefile',
}
