local dap = require("dap");
local fn = vim.fn;

local buf_basename = function()
  return fn.expand("%:r");
end;

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
};

local gdb = {
  name = "Launch",
  type = "gdb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", fn.getcwd() .. "/", "file");
  end,
  cwd = "${workspaceFolder}",
  stopAtBeginningOfMainSubprogram = false,
};

dap.configurations.c = { gdb };
dap.configurations.cpp = { gdb };
dap.configurations.rust = { gdb };
