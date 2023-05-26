local opts = { noremap = true }

local map = vim.keymap.set
local del = vim.keymap.del
local cmd = vim.cmd
local g = vim.g

g.mapleader = ' '
g.maplocalleader = g.mapleader

map('n', '<leader>q', ':qa!<cr>', opts)
map('n', 'sq', ':q!<cr>', opts)
map('n', 'saq', ':wqa!<cr>', opts)
map('n', 'sw', ':w!<cr>', opts)
map('n', 'saw', ':wa!<cr>', opts)
map('n', 'ss', ':split<cr>', opts)
map('n', 'sv', ':vsplit<cr>', opts)
map('n', 's<s-T>', ':tab ', opts)
map('n', 'sh', ':wincmd h<cr>', opts)
map('n', 'sk', ':wincmd k<cr>', opts)
map('n', 'sj', ':wincmd j<cr>', opts)
map('n', 'sl', ':wincmd l<cr>', opts)
map('n', 'st', ':tabnew ', opts)
map('n', 'sp', ':tabp<cr>', opts)
map('n', 'sn', ':tabn<cr>', opts)
map('n', 'sd', ':SwapDelete<cr>', opts)

map('n', '<m-L>', ':vertical resize +1<cr>', opts)
map('n', '<m-H>', ':vertical resize -1<cr>', opts)
map('n', '<m-K>', ':resize +1<cr>', opts)
map('n', '<m-J>', ':resize -1<cr>', opts)

map('n', '<leader>t', ':tabnew<cr>', opts)
map('n', '<leader><S-L>', ':nohl<cr>', opts)
map('n', '<leader>e', ':Explore<cr>', opts)
map('n', '<leader>u', ':UndotreeToggle<cr>', opts)
map('n', '<leader>n', ':NvimTreeFocus<cr>', opts)

map('n', '<leader>p', '<esc>"+p', opts)
map('n', '<leader>yy', '<esc>"+yy', opts)
map('v', '<leader>y', '"+y', opts)

map('n', '<leader>ff', ':Telescope find_files<cr>', opts)
map('n', '<leader>fg', ':Telescope live_grep<cr>', opts)
map('n', '<leader>fh', ':Telescope help_tags<cr>', opts)

map('n', '<leader>dd', ':Bdelete!<cr>', opts)
map('n', '<leader>dc', function()
  local choose = { 'Choose a buffer' }
  for _, buf in pairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    if #buf.name == 0 then
      vim.api.nvim_buf_delete(buf.bufnr, {force=true})
    else
      table.insert(choose, buf.bufnr .. ': ' .. buf.name)
    end
  end

  local input = vim.fn.inputlist(choose)
  if input ~= 0 then
    vim.api.nvim_buf_delete(input, { force = true })
  end
end, opts)

map('n', '<leader>wk', function()
  local input = vim.fn.input'WhichKey: '
  if #input == 0 then
    return
  end
  input = input:gsub(vim.g.mapleader, '<leader>')
  cmd.WhichKey(input)
end, opts)


local path = vim.fn.stdpath'data'..'/sessions'
local dir = vim.fn.getcwd():gsub('/', '_')
local sessionfile = string.format('%s/%s', path, dir)

map('n', '<leader>sl', function()
  if vim.fn.filereadable(sessionfile) == 1 then
    print'Loading Session'
    cmd.source(sessionfile)
    print'Session Loaded'
  else
    print'Session not found'
  end
end, opts)

map('n', '<leader>ss', function()
  cmd(string.format('mksession! %s', sessionfile))
  print'Session Saved'
end, opts)
