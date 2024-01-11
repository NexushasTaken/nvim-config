local util = require 'lspconfig.util'

local port = os.getenv('GDScript_Port') or '6008'
local cmd = { 'nc', 'localhost', port }
local pipe = os.getenv('GDScript_Pipe') or '/tmp/nvim.godot.pipe'

if vim.fn.has('nvim-0.8') == 1 then
  cmd = vim.lsp.rpc.connect('127.0.0.1', port)
end

return {
  default_config = {
    name = 'Godot',
    cmd = cmd,
    filetypes = { 'gd', 'gdscript', 'gdscript3' },
    root_dir = util.root_pattern('project.godot'),
    -- root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
      vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
    end,
  },
  docs = {
    description = [[
https://github.com/godotengine/godot

Language server for GDScript, used by Godot Engine.
]],
    default_config = {
      root_dir = [[util.root_pattern("project.godot", ".git")]],
    },
  },
}
