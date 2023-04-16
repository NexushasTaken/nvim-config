local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require'nexus.lsp.mason'
require'nexus.lsp.handlers'.setup()
require'nexus.lsp.null-ls'
