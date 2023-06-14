local M = {}

local cmp_nvim_lsp = require'cmp_nvim_lsp'

M.capabilities = vim.lsp.protocol.make_client_capabilities()
--[[ M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
} ]]
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn',  text = '' },
    { name = 'DiagnosticSignHint',  text = '' },
    { name = 'DiagnosticSignInfo',  text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
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
      style = 'none',
      border = 'none',
      source = 'none',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_buf_set_keymap
  map(bufnr, 'n', 'g<S-D>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map(bufnr, 'n', 'g<S-I>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map(bufnr, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', opts)
  map(bufnr, 'n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  map(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  map(bufnr, 'n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>', opts)
  map(bufnr, 'n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>', opts)
  map(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  map(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  if client.name == "omnisharp" then
    if client.name == 'omnisharp' then
      local tokenModifiers =
        client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
      for i, v in ipairs(tokenModifiers) do
        tokenModifiers[i] = v:gsub(' ', '_')
      end
      local tokenTypes =
        client.server_capabilities.semanticTokensProvider.legend.tokenTypes
      for i, v in ipairs(tokenTypes) do
        tokenTypes[i] = v:gsub(' ', '_')
      end
    end
  end
end

return M
