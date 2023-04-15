local opts = { noremap = true }

-- Shorten function name
local map = vim.api.nvim_set_keymap

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map('n', '<leader>q', ':qa!<cr>', opts)
map('n', 'sq', ':q!<cr>', opts)
map('n', 'saq', ':wqa!<cr>', opts)
map('n', 'sw', ':w!<cr>', opts)
map('n', 'saw', ':wa!<cr>', opts)
map('n', 'ss', ':split<cr>', opts)
map('n', 'sv', ':vsplit<cr>', opts)
map('n', 's<s-T>', ':tabnew<cr>', opts)
map('n', 'sh', ':wincmd h<cr>', opts)
map('n', 'sk', ':wincmd k<cr>', opts)
map('n', 'sj', ':wincmd j<cr>', opts)
map('n', 'sl', ':wincmd l<cr>', opts)
map('n', 'st', ':tabnew ', opts)
map('n', 'sp', ':tabp<cr>', opts)
map('n', 'sn', ':tabn<cr>', opts)

map('n', '<m-L>', ':vertical resize +1<cr>', opts)
map('n', '<m-H>', ':vertical resize -1<cr>', opts)
map('n', '<m-K>', ':resize +1<cr>', opts)
map('n', '<m-J>', ':resize -1<cr>', opts)

map('n', 'sd', ':SwapDelete<cr>', opts)
map('n', '<leader>t', ':tabnew<cr>', opts)
map('n', '<leader>l', ':nohl<cr>', opts)
map('n', '<leader>e', ':Explore<cr>', opts)
map('n', '<leader>u', ':UndotreeToggle<cr>', opts)
map('n', '<leader>n', ':NvimTreeFocus<cr>', opts)

map('n', '<leader>p', '<esc>"+p', opts)
map('n', '<leader>yy', '<esc>"+yy', opts)
map('v', '<leader>y', '"+y', opts)

map('n', "<leader>ff", ":Telescope find_files<cr>", opts)
map('n', "<leader>fg", ":Telescope live_grep<cr>", opts)
map('n', "<leader>fh", ":Telescope help_tags<cr>", opts)
