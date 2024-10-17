local dap = require("dap")
local fn = vim.fn

local buf_basename = function()
	return fn.expand("%:r")
end

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	name = "gdb",
}

local gdb = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input(
				"Path to executable: ",
				vim.fn.getcwd() .. "/",
				"file"
			)
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		--stopAtBeginningOfMainSubprogram = false,
		--MIMode = "gdb",
		--miDebuggerPath = "/usr/bin/gdb",
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input(
				"Path to executable: ",
				vim.fn.getcwd() .. "/",
				"file"
			)
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input(
				"Path to executable: ",
				vim.fn.getcwd() .. "/",
				"file"
			)
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.c = gdb
dap.configurations.cpp = gdb
dap.configurations.rust = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		-- This is where cargo outputs the executable
		program = function()
			os.execute("cargo build &> /dev/null")

			return "target/debug/" .. vim.fn.input("Executable name: ", "file")
		end,
		args = function()
			local argv = {}
			arg = vim.fn.input(string.format("argv: "))
			for a in string.gmatch(arg, "%S+") do
				table.insert(argv, a)
			end
			return argv
		end,
		cwd = "${workspaceFolder}",
		-- Uncomment if you want to stop at main
		-- stopOnEntry = true,
		MIMode = "gdb",
		miDebuggerPath = "/usr/bin/gdb",
	},
}
