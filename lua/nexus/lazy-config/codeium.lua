local g = vim.g;
local map = vim.keymap.set;

return function()
  map("n", "<m-a>", function() return vim.cmd["Codedium"]("Auth") end, { expr = true, silent = true })
  map("i", "<m-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
  map("i", "<m-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
  map("i", "<m-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
  map("i", "<m-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })

  -- g.codeium_manual = true;
  g.codeium_disable_bindings = 1;
  if vim.fn.executable("codeium_language_server") == 1 then
    g.codeium_bin = vim.fn.exepath("codeium_language_server");
  end
end;
