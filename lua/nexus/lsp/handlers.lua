local M = {};

local conform = require("conform");
local cmp_nvim_lsp = require("cmp_nvim_lsp");

M.capabilities = vim.lsp.protocol.make_client_capabilities();
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities);

M.setup = function()
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
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, };
  local map = vim.api.nvim_buf_set_keymap;
  map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts);
  map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts);
  map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts);
  map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts);
  map(bufnr, "n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts);
  map(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts);
  map(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts);
  map(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts);
  map(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts);
  map(bufnr, "n", "<leader>lh", "<cmd>lua vim.lsp.buf.document_highlight()<CR>", opts);
  map(bufnr, "n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts);
  vim.api.nvim_create_autocmd({"CursorMoved"}, {
    buffer = bufnr,
    command = "lua vim.lsp.buf.clear_references()",
  })
end

local toSnakeCase = function(str)
  return string.gsub(str, "%s*[- ]%s*", "_")
end

M.on_attach = function(client, bufnr)
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

return M
