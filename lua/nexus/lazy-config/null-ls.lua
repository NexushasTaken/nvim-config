local mason = require'mason'
local null_ls = require'null-ls'

local my_source = {
-- source will run on LSP code action request
  [null_ls.methods.CODE_ACTION] = true,

-- source will run on LSP diagnostics request
  [null_ls.methods.DIAGNOSTICS] = true,

-- source will run on LSP formatting request
  [null_ls.methods.FORMATTING] = true,

-- source will run on LSP hover request
  [null_ls.methods.HOVER] = true,

-- source will run on LSP completion request
  [null_ls.methods.COMPLETION] = true,
}

for key, _ in pairs(null_ls.methods) do
  my_source[key] = true
end

mason.setup()
null_ls.setup{
  setup = {
    my_source
  }
}
