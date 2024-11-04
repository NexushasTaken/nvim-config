local map = vim.keymap.set;
local cmd = vim.cmd;
local g = vim.g;

g.mapleader = " ";
g.maplocalleader = g.mapleader;

map("n", "<leader>q", ":qa!<cr>", { noremap = true, });
map("n", "ss", ":split<cr>", { noremap = true, });
map("n", "sv", ":vsplit<cr>", { noremap = true, });
map("n", "sh", ":wincmd h<cr>", { noremap = true, });
map("n", "sk", ":wincmd k<cr>", { noremap = true, });
map("n", "sj", ":wincmd j<cr>", { noremap = true, });
map("n", "sl", ":wincmd l<cr>", { noremap = true, });
map("n", "st", ":tabnew ", { noremap = true, });
map("n", "sp", ":tabprev<cr>", { noremap = true, });
map("n", "sn", ":tabnext<cr>", { noremap = true, });
map("n", "sd", ":SwapDelete<cr>", { noremap = true, });

map("n", "<m-L>", ":vertical resize +1<cr>", { noremap = true, });
map("n", "<m-H>", ":vertical resize -1<cr>", { noremap = true, });
map("n", "<m-K>", ":resize +1<cr>", { noremap = true, });
map("n", "<m-J>", ":resize -1<cr>", { noremap = true, });

map("n", "<leader><S-L>", ":nohl<cr>", { noremap = true, });
map("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true, });
map("n", "<leader>n", ":NvimTreeFocus<cr>", { noremap = true, });

map("n", "<leader>p", '<esc>"+p', { noremap = true, });
map("n", "<leader>yy", '<esc>"+yy', { noremap = true, });
map("v", "<leader>y", '"+y', { noremap = true, });

map("n", "<leader>o", ":Oil<cr>", { noremap = true, });
map("n", "<leader>O", ":Oil ", { noremap = true, });

map("n", "<leader>wk", function()
  local input = vim.fn.input("WhichKey: ");
  local leader = vim.g.mapleader;
  if #input == 0 then
    return;
  end
  input = input:gsub(leader, "<leader>");

  local lbuf = vim.bo[vim.api.nvim_get_current_buf()];
  local lmod = lbuf.modifiable;
  vim.cmd.WhichKey(input);
  lbuf.modifiable = lmod;
end, { noremap = true, desc = "WhichKey", });

map("n", "zZ", function()
  if vim.opt.foldmethod:get() == "manual" then
    vim.opt.foldmethod = "expr";
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()";
    print("fold method: expr");
  elseif vim.opt.foldmethod:get() == "expr" then
    vim.opt.foldmethod = "manual";
    vim.opt.foldexpr = "0";
    print("fold method: manual");
  end
end, { noremap = true, });

map("n", "<leader>dd", ":Bdelete!<cr>", { noremap = true, });
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
end, { noremap = true, })

map("n", "gl", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, });
map("n", "<leader>lj", ":lua vim.diagnostic.goto_next({buffer=0})<cr>", { noremap = true, });
map("n", "<leader>lk", ":lua vim.diagnostic.goto_prev({buffer=0})<cr>", { noremap = true, });
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
end, { noremap = true, });

map("n", "<leader>ss", function()
  cmd(string.format("mksession! %s", sessionfile));
  print("Session Saved");
end, { noremap = true, });

map("n", "<leader>t", function()
  if #vim.fn.bufname("%") > 0 then
    local save = vim.fn.winsaveview();
    for _, pattern in ipairs({ [[%s/\s\+$//e]], [[%s/\%^\n\+//]], [[%s/\($\n\s*\)\+\%$//]] }) do
      vim.api.nvim_exec2(string.format("keepjumps keeppatterns silent! %s", pattern), { output = false });
    end
    vim.fn.winrestview(save);

    vim.api.nvim_exec2("silent! write", { output = false });
  end
end, { noremap = true, });

-- TODO: Figure this out why 'w' is appending when testcase keybinds are executed.
local remove_w = function()
  local keys = vim.api.nvim_replace_termcodes("<BS><ESC>", true, false, true)
  vim.api.nvim_feedkeys(keys, "x", false)
end

map("n", "<leader>au", function() require("textcase").current_word("to_upper_case");    remove_w(); end, { noremap = true, desc="TO UPPER CASE", });
map("n", "<leader>al", function() require("textcase").current_word("to_lower_case");    remove_w(); end, { noremap = true, desc="to lower case", });
map("n", "<leader>as", function() require("textcase").current_word("to_snake_case");    remove_w(); end, { noremap = true, desc="to_snake_case", });
map("n", "<leader>ad", function() require("textcase").current_word("to_dash_case");     remove_w(); end, { noremap = true, desc="to.dash.case", });
map("n", "<leader>an", function() require("textcase").current_word("to_constant_case"); remove_w(); end, { noremap = true, desc="TO_CONSTANT_CASE", });
map("n", "<leader>ad", function() require("textcase").current_word("to_dot_case");      remove_w(); end, { noremap = true, desc="to.dot.case", });
map("n", "<leader>a,", function() require("textcase").current_word("to_comma_case");    remove_w(); end, { noremap = true, desc="to,comma,case", });
map("n", "<leader>aa", function() require("textcase").current_word("to_phrase_case");   remove_w(); end, { noremap = true, desc="To phrase case", });
map("n", "<leader>ac", function() require("textcase").current_word("to_camel_case");    remove_w(); end, { noremap = true, desc="toCamelCase", });
map("n", "<leader>ap", function() require("textcase").current_word("to_pascal_case");   remove_w(); end, { noremap = true, desc="ToPascalCase", });
map("n", "<leader>at", function() require("textcase").current_word("to_title_case");    remove_w(); end, { noremap = true, desc="To Title Case", });
map("n", "<leader>af", function() require("textcase").current_word("to_path_case");     remove_w(); end, { noremap = true, desc="to/path/case", });

map("v", "<leader>au", function() require("textcase").current_word("to_upper_case");    remove_w(); end, { noremap = true, desc="TO UPPER CASE", });
map("v", "<leader>al", function() require("textcase").current_word("to_lower_case");    remove_w(); end, { noremap = true, desc="to lower case", });
map("v", "<leader>as", function() require("textcase").current_word("to_snake_case");    remove_w(); end, { noremap = true, desc="to_snake_case", });
map("v", "<leader>ad", function() require("textcase").current_word("to_dash_case");     remove_w(); end, { noremap = true, desc="to.dash.case", });
map("v", "<leader>an", function() require("textcase").current_word("to_constant_case"); remove_w(); end, { noremap = true, desc="TO_CONSTANT_CASE", });
map("v", "<leader>ad", function() require("textcase").current_word("to_dot_case");      remove_w(); end, { noremap = true, desc="to.dot.case", });
map("v", "<leader>a,", function() require("textcase").current_word("to_comma_case");    remove_w(); end, { noremap = true, desc="to,comma,case", });
map("v", "<leader>aa", function() require("textcase").current_word("to_phrase_case");   remove_w(); end, { noremap = true, desc="To phrase case", });
map("v", "<leader>ac", function() require("textcase").current_word("to_camel_case");    remove_w(); end, { noremap = true, desc="toCamelCase", });
map("v", "<leader>ap", function() require("textcase").current_word("to_pascal_case");   remove_w(); end, { noremap = true, desc="ToPascalCase", });
map("v", "<leader>at", function() require("textcase").current_word("to_title_case");    remove_w(); end, { noremap = true, desc="To Title Case", });
map("v", "<leader>af", function() require("textcase").current_word("to_path_case");     remove_w(); end, { noremap = true, desc="to/path/case", });
