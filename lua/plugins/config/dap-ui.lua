return function()
  local opt = vim.opt;
  local map = vim.keymap.set;
  local cmd = vim.cmd;
  local dap = require("dap");
  local dapui = require("dapui");

  -- TODO: implement a better way to set readonly for each buffers.
  local augroup = vim.api.nvim_create_augroup("DapGroup", { clear = true });

  local open = function()
    vim.api.nvim_create_autocmd({ "BufEnter", }, {
      group = augroup,
      callback = function()
        opt.modifiable = false;
      end,
    });
    opt.modifiable = false;
    dapui.open();
  end;
  local close = function()
    vim.api.nvim_clear_autocmds({group = "DapGroup"});
    dapui.close();
  end;

  dap.listeners.before.attach.dapui_config = open;
  dap.listeners.before.launch.dapui_config = open;
  dap.listeners.before.event_terminated.dapui_config = close;
  dap.listeners.before.event_exited.dapui_config = close;

  map("n", "<F2>", function() cmd.DapNew(); end, { noremap = true, });
  map("n", "<F3>", function() dap.restart(); end, { noremap = true, });
  map("n", "<F4>", function() dap.continue(); end, { noremap = true, });
  map("n", "<F5>", function() dap.terminate(); end, { noremap = true, });
  map("n", "<F6>", function() dap.toggle_breakpoint(); end, { noremap = true, });
  map("n", "<F7>", function() dap.step_over(); end, { noremap = true, });
  map("n", "<F8>", function() dap.step_into(); end, { noremap = true, });
  map("n", "<F9>", function() dap.step_out(); end, { noremap = true, });

  dapui.setup({
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25
      }, {
        id = "stacks",
        size = 0.25
      }, {
        id = "watches",
        size = 0.25
      } },
      position = "left",
      size = 40
    }, {
      elements = { {
        id = "repl",
        size = 0.5
      }, {
        id = "console",
        size = 0.5
      } },
      position = "bottom",
      size = 20
    } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  });
end;
