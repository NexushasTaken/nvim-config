local servers = {
  "bashls",
  "lua_ls",
  "jsonls",
  "yamlls",
  "clangd",
  "jdtls",
  "omnisharp",
  "pyright",
  "html",
  "rust_analyzer",
  "cmake",
  "tsserver",
  "asm_lsp",
};

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
};

require("mason").setup(settings);

local lspconfig = require("lspconfig");

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require"nexus.lsp.handlers".on_attach,
    capabilities = require"nexus.lsp.handlers".capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "nexus.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts.default_config, opts)
  end

  lspconfig[server].setup(opts)
end
