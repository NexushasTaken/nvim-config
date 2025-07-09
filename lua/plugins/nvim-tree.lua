return {
  { -- File browser
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFocus" },
    opts = require("plugins.config.nvim-tree"),
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Icons
    },
  },
};
