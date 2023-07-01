local nls_ok, null_ls = pcall(require, "null-ls")
if not nls_ok then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote", } }),
    formatting.black.with({ extra_args = { "--fast", } }),
    formatting.stylua,
  },
})
