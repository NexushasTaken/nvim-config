local configs = require("nvim-treesitter.configs");

configs.setup({
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

-- # c3 language
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
});

local parser_config = require("nvim-treesitter.parsers").get_parser_configs();
parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main",
  },
};
-- > c3 language
