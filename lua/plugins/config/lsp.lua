local M = {};

M.servers = {
  ols = {},
  bashls = {},
  lua_ls = {},
  jsonls = {},
  yamlls = {},
  clangd = {},
  jdtls = {},
  omnisharp = {},
  pyright = {},
  html = {},
  rust_analyzer = {},
  cmake = {},
  ts_ls = {},
  asm_lsp = {},
  gopls = {},
  cssls = {},
  serve_d = {},
  gdscript = {},
  svelte = {},
  nimls = {},
  zls = {},
  c3_lsp = {},
  glsl_analyzer = {},
  v_analyzer = {},
  qmlls = {
    cmd = { "qmlls", "-E" },
  },
  basedpyright = {},
};

local blink = require("blink.cmp");

M.capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = true,
      lineFoldingOnly = true,
    },
  },
};

M.capabilities = blink.get_lsp_capabilities(M.capabilities);

M.on_attach = function(client, bufnr)
  local function toSnakeCase(str)
    return string.gsub(str, "%s*[- ]%s*", "_")
  end

  local function lsp_keymaps(buf)
    local opts = { noremap = true, silent = true, };
    local map = vim.api.nvim_buf_set_keymap;
    map(buf, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts);
    map(buf, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts);
    map(buf, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts);
    map(buf, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts);
    map(buf, "n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts);
    map(buf, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts);
    map(buf, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts);
    map(buf, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts);
    map(buf, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts);
    map(buf, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.document_highlight()<CR>", opts);
    map(buf, "n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts);
    vim.api.nvim_create_autocmd({"CursorMoved"}, {
      buffer = buf,
      command = "lua vim.lsp.buf.clear_references()",
    })
  end

  lsp_keymaps(bufnr);

  -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
  if client.name == "omnisharp" then
    local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
    for i, v in ipairs(tokenModifiers) do
      tokenModifiers[i] = toSnakeCase(v)
    end
    local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
    for i, v in ipairs(tokenTypes) do
      tokenTypes[i] = toSnakeCase(v)
    end
  end
end


local lspconfig = require("lspconfig");
for server, server_config in pairs(M.servers) do
  local config = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  };

  config = vim.tbl_deep_extend("force", config, server_config);

  --vim.lsp.enable(server);
  vim.lsp.config(server, config);
end


local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
};

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "", });
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "none",
    border = "none",
    source = "none",
    header = "",
    prefix = "",
  },
};

vim.diagnostic.config(config);

return M;
