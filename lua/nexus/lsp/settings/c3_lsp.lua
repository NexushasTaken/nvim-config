local util = require("lspconfig.util");

local cmd = { "c3-lsp" };
local root_files = { "project.json", "manifest.json", ".git" };
return {
  default_config = {
    cmd = cmd,
    filetypes = { "c3", "c3i", "c3t" },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname)
    end,
    single_file_support = true,
    init_options = {
      buildDirectory = 'build',
    },
  },
  docs = {
    description = [[
https://github.com/pherrymason/c3-lsp

Language Server for C3 Language
]],
    default_config = {
      root_dir = [[root_pattern("project.json", "manifest.json")]],
    },
  },
};
