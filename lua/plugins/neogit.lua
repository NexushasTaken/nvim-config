return {
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      {
        "sindrets/diffview.nvim",
        config = require("plugins.config.diffview"),
      },

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = require("plugins.config.diffview"),
  },
}
