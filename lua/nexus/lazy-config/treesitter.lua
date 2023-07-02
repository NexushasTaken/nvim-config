local configs = require("nvim-treesitter.configs");

configs.setup({
  highlight = {
    use_languagetree = true,
    enable = true,
  },
});
