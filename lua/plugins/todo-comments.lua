return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = require("plugins.config.todo-comments"),
    lazy = false,
  },
}
