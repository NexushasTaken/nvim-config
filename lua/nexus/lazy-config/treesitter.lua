local configs = require("nvim-treesitter.configs");

configs.setup({
  parser_install_dir = vim.fn.stdpath("data"),
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
	},
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = false,
  },
});

vim.opt.runtimepath:append(vim.fn.stdpath("data"))
