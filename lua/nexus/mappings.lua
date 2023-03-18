local cmd = vim.cmd

return {
  { 'n', '<leader>q', ':qa!<cr>', },
  { 'n', 'sq', ':q!<cr>', },
  { 'n', 'saq', ':wqa!<cr>', },
  { 'n', 'sw', ':w!<cr>', },
  { 'n', 'saw', ':wa!<cr>', },
  { 'n', 'ss', ':split<cr>', },
  { 'n', 'sv', ':vsplit<cr>', },
  { 'n', 'st', ':tabnew<cr>', },
  { 'n', 'sh', ':wincmd h<cr>', },
  { 'n', 'sk', ':wincmd k<cr>', },
  { 'n', 'sj', ':wincmd j<cr>', },
  { 'n', 'sl', ':wincmd l<cr>', },
  { 'n', 'st', ':tabnew ', },
  { 'n', 'sp', ':tabp<cr>', },
  { 'n', 'sn', ':tabn<cr>', },

  { 'n', '<m-L>', ':vertical resize +1<cr>', },
  { 'n', '<m-H>', ':vertical resize -1<cr>', },
  { 'n', '<m-K>', ':resize +1<cr>', },
  { 'n', '<m-J>', ':resize -1<cr>', },

  { 'n', 's<right>', ':vertical resize +1<cr>', },
  { 'n', 's<left>', ':vertical resize -1<cr>', },
  { 'n', 's<up>', ':resize +1<cr>', },
  { 'n', 's<down>', ':resize -1<cr>', },

  { 'n', 'sd', ':SwapDelete<cr>', },
  { 'n', '<leader>t', ':tabnew<cr>', },
  { 'n', '<leader>l', ':nohl<cr>', },
  { 'n', '<leader>e', ':Explore<cr>', },
  { 'n', '<leader>u', ':UndotreeToggle<cr>', },
  { 'n', '<leader>n', ':NvimTreeFocus<cr>', },

  { 'n', '<leader>p', '<esc>"+p', },
  { 'n', '<leader>yy', '<esc>"+yy', },
  { 'v', '<leader>y', '"+y', },

  { 'n', "<leader>ff", ":Telescope find_files<cr>", },
  { 'n', "<leader>fg", ":Telescope live_grep<cr>", },
  { 'n', "<leader>fh", ":Telescope help_tags<cr>", },

  {
    'n', '<leader>ss', function()
      cmd'SessionsSave'
      print'Session Saved'
    end
  },
  {
    'n', '<leader>sl', function()
      cmd'SessionsLoad'
      print'Session Loaded'
    end
  },
}
