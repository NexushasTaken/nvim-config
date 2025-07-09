return function()
  local MiniDeps = require("mini.deps")
  --MiniDeps.add({
  --  source = "saghen/blink.cmp",
  --  depends = { "rafamadriz/friendly-snippets" },
  --  checkout = "v1.4.1", -- check releases for latest tag
  --})

  --local function build_blink(params)
  --  vim.notify('Building blink.cmp', vim.log.levels.INFO)
  --  local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
  --  if obj.code == 0 then
  --    vim.notify('Building blink.cmp done', vim.log.levels.INFO)
  --  else
  --    vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
  --  end
  --end

  --MiniDeps.add({
  --  source = 'Saghen/blink.cmp',
  --  hooks = {
  --    post_install = build_blink,
  --    post_checkout = build_blink,
  --  },
  --})
end
