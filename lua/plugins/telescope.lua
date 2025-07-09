return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = require("plugins.config.telescope"),
    dependencies = {
      "nvim-lua/plenary.nvim", -- Some tools for Lua?
    },
  },
}
