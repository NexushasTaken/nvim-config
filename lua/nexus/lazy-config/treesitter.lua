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

local ts_add = function(dir, name, ext)
  dir = dir or vim.fn.getcwd();
  dir = vim.uv.fs_realpath(dir) or dir;
  name = name or string.gsub(vim.fs.basename(dir), "tree%-sitter%-(.+)", "%1");
  ext = ext or name;

  local grammar = dir .. "/grammar.js";
  if vim.fn.filereadable(grammar) == 0 then
    vim.notify(string.format("%s is not a proper tree-sitter project", dir), vim.log.levels.ERROR);
    return;
  end

  if parser_config[name] == nil then
    local files = { "src/parser.c", };
    if vim.fn.filereadable(dir .. "/src/scanner.c") == 1 then
      table.insert(files, "src/scanner.c")
    end

    vim.opt.runtimepath:append(dir);
    parser_config[name] = {
      install_info = {
        url = dir,
        files = files,
      },
    };
    vim.filetype.add({
      extension = { [ext] = ext },
    });
    vim.treesitter.language.register(name, ext);
  end

  vim.cmd("silent TSUpdateSync " .. name);
end

vim.api.nvim_create_user_command("TSAdd", function(opts)
  --if #opts.fargs < 1 or #opts.fargs > 2 then
  --  print("Usage: TSAddCWD <language_name> [<extension>]");
  --  return;
  --end
  ts_add(opts.fargs[1], opts.fargs[2], opts.fargs[3]);
end, { nargs = "+" });
