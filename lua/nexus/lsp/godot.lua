-- https://simondalvai.org/blog/godot-neovim/
local lspconfig = require("lspconfig");

-- paths to check for project.godot file
local paths_to_check = {"/", "/../"};
local is_godot_project = false;
local godot_project_path = "";
local cwd = vim.fn.getcwd();

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

local server_file = godot_project_path .. "/.godot/server.pipe"
-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(server_file)
-- start server, if not already running
if is_godot_project and not is_server_running then
  vim.fn.serverstart(server_file)
end

if is_godot_project then
  lspconfig.gdscript.setup({})
end
