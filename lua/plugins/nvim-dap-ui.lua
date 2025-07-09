return {
  { -- Debugger
    "rcarriga/nvim-dap-ui",
    keys = {
      "<F2>",
      "<F3>",
      "<F4>",
      "<F5>",
      "<F6>",
      "<F7>",
      "<F8>",
      "<F9>",
    },
    cmd = {
      "DapContinue",
      "DapDisconnect",
      "DapEval",
      "DapInstall",
      "DapLoadLaunchJSON",
      "DapNew",
      "DapRestartFrame",
      "DapSetLogLevel",
      "DapShowLog",
      "DapStepInto",
      "DapStepOut",
      "DapStepOver",
      "DapTerminate",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapUninstall",
    },
    config = require("plugins.config.dap-ui"),
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = {},
          automatic_installation = false,
          handlers = {
            function(config)
              require("mason-nvim-dap").default_setup(config);
            end,
          },
        },
        dependencies = {
          "williamboman/mason.nvim",
          "mfussenegger/nvim-dap",
        },
      },
    },
  },
};
