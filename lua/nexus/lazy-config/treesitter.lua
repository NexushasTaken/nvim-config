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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs();
-- # c3 language
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
});

parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main",
  },
};
-- > c3 language

-- # tup
vim.filetype.add({
  extension = {
    tup = "tup",
  },
  filename = {
    ["tup.config"] = "tup",
    ["Tupfile"] = "tup",
  },
});
parser_config.tup = {
  install_info = {
    url = "https://github.com/RoBaertschi/tree-sitter-tup",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main",
  },
};
-- > tup

vim.api.nvim_create_user_command("TSAddCurrentProject", function(opts)
  if #opts.fargs < 1 or #opts.fargs > 2 then
    print("Usage: TSAddCurrentProject <language_name> [<extension>]");
    return;
  end

  local name = opts.fargs[1];
  local ext = opts.fargs[2] or name;
  local cwd = vim.fn.getcwd();
  local grammar = cwd .. "/grammar.js";
  if vim.fn.filereadable(grammar) == 0 then
    print("Current directory is not a tree-sitter project");
    return;
  end

  if parser_config[name] == nil then
    vim.opt.runtimepath:append(cwd);
  end

  vim.filetype.add({
    extension = { [ext] = ext },
  });
  parser_config[name] = {
    install_info = {
      url = cwd,
      files = { "src/parser.c" },
    },
  };
  vim.treesitter.language.register(name, ext);
  vim.cmd.TSUninstall(name);
  vim.cmd.TSInstall(name);
end, { nargs = "+" });
