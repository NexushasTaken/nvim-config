local configs = require("nvim-treesitter.configs");
local parsers = require("nvim-treesitter.parsers");

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

parsers.list.xml = {
  install_info = {
    url = "https://github.com/Trivernis/tree-sitter-xml",
    files = { "src/parser.c" },
    generate_requires_npm = true,
    branch = "main",
  },
  filetype = "xml",
};
vim.opt.runtimepath:append(vim.fn.stdpath("data"))
