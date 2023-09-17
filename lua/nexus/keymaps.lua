local opts = { noremap = true, };

local map = vim.keymap.set;
local cmd = vim.cmd;
local g = vim.g;

g.mapleader = " ";
g.maplocalleader = g.mapleader;

map("n", "<leader>q", ":qa!<cr>", opts);
map("n", "sq", ":q!<cr>", opts);
map("n", "saq", ":wqa!<cr>", opts);
map("n", "sw", ":w!<cr>", opts);
map("n", "saw", ":wa!<cr>", opts);
map("n", "ss", ":split<cr>", opts);
map("n", "sv", ":vsplit<cr>", opts);
map("n", "s<s-T>", ":tab ", opts);
map("n", "sh", ":wincmd h<cr>", opts);
map("n", "sk", ":wincmd k<cr>", opts);
map("n", "sj", ":wincmd j<cr>", opts);
map("n", "sl", ":wincmd l<cr>", opts);
map("n", "st", ":tabnew ", opts);
map("n", "sp", ":tabprev<cr>", opts);
map("n", "sn", ":tabnext<cr>", opts);
map("n", "sd", ":SwapDelete<cr>", opts);

map("n", "<m-L>", ":vertical resize +1<cr>", opts);
map("n", "<m-H>", ":vertical resize -1<cr>", opts);
map("n", "<m-K>", ":resize +1<cr>", opts);
map("n", "<m-J>", ":resize -1<cr>", opts);

map("n", "<leader>b", ":buffer ", opts);
map("n", "<leader>t", ":tabnew<cr>", opts);
map("n", "<leader><S-L>", ":nohl<cr>", opts);
map("n", "<leader>u", ":UndotreeToggle<cr>", opts);
map("n", "<leader>n", ":NvimTreeFocus<cr>", opts);

map("n", "<leader>p", '<esc>"+p', opts);
map("n", "<leader>yy", '<esc>"+yy', opts);
map("v", "<leader>y", '"+y', opts);

map("n", "<leader>ff", ":Telescope find_files<cr>", opts);
map("n", "<leader>fg", ":Telescope live_grep<cr>", opts);
map("n", "<leader>fh", ":Telescope help_tags<cr>", opts);
map("n", "<leader>fb", ":Telescope buffers<cr>", opts);
map("n", "<leader>ft", ":Telescope tags<cr>", opts);

map("n", "<leader>o", ":Oil<cr>", opts);
map("n", "<leader>O", ":Oil ", opts);

map("n", "<leader>dd", ":Bdelete!<cr>", opts);
map("n", "<leader>dc", function()
  local choose = { "Choose a buffer", };
  for _, buf in pairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    if #buf.name == 0 then
      vim.api.nvim_buf_delete(buf.bufnr, { force = true });
    else
      table.insert(choose, buf.bufnr .. ": " .. buf.name);
    end
  end

  local input = vim.fn.inputlist(choose);
  if input ~= 0 then
    vim.api.nvim_buf_delete(input, { force = true });
  end
end, opts)

map("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts);
map("n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<cr>", opts);
map("n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts);
map("n", "<leader>m", function()
  local lbuf = vim.bo[vim.api.nvim_get_current_buf()];
  lbuf.modifiable = not lbuf.modifiable;
  print(lbuf.modifiable and "ReadWrite" or "Readonly");
end);

local is_qwerty = true;
map("n", "<leader>cl", function()
  if is_qwerty then
   vim.opt["langmap"] = "nir;jkl,jkl;nir,NIR;JKL,JKL;NIR";
   print("Layout: Colemak Niro");
  else
   vim.opt["langmap"] = "";
   print("Layout: QWERTY");
  end
  is_qwerty = not is_qwerty;
end);


local sessionfile = string.format("%s/%s",
  vim.fn.stdpath("data").."/sessions",
  vim.fn.getcwd():gsub("/", "_"));

map("n", "<leader>sl", function()
  if vim.fn.filereadable(sessionfile) == 1 then
    print("Loading Session");
    cmd.source(sessionfile);
    print("Session Loaded");
  else
    print("Session not found");
  end
end, opts);

map("n", "<leader>ss", function()
  cmd(string.format("mksession! %s", sessionfile));
  print("Session Saved");
end, opts);
