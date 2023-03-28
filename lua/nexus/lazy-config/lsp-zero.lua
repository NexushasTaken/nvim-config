local lsp = require'lsp-zero'

lsp.preset'recommended'
lsp.configure('clangd', {
  cmd = {
    'clangd',
    '--offset-encoding=utf-8',
    '--header-insertion=never',
  },
})
lsp.configure('lua_ls', {
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
})
lsp.setup_nvim_cmp{
  documentation = {
    max_width = 0,
    max_height = 0,
  }
}
lsp.setup()
