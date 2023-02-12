local lsp = require 'lsp-zero'
local lsp_configs = {
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
        telemetry = { enable = false },
      }
    }
  }
}

for server, config in pairs(lsp_configs) do
  lsp.configure(server, config)
end

lsp.preset 'recommended'
lsp.setup()
