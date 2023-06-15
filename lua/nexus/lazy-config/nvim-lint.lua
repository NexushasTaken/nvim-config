local lint = require'lint'
local cmd = vim.cmd
local api = vim.api
local create_cmd = api.nvim_create_user_command
local glint = api.nvim_create_augroup('nvim-lint', { clear = true })

-- Linter enable/disable
local enabled = false

lint.linters_by_ft = {
  c   = { 'cpplint' },
  cpp = { 'cpplint' },
}

lint.linters.cpplint.args = {
  '--filter=-legal/copyright,-build/header_guard,-build/c++11',
}

create_cmd('Lint', function() lint.try_lint() end, { nargs = 0 })

create_cmd('LintEnable', function()
    if not enabled then
      enabled = true
      api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
        group = glint,
        callback = function() cmd.Lint() end,
      })
      cmd.Lint()
      print('Linter Enabled')
    end
  end, { nargs = 0 })

create_cmd('LintDisable', function()
    if enabled then
      enabled = false

      vim.diagnostic.hide()
      api.nvim_clear_autocmds({ group = glint })
      print('Linter Disabled')
    end
  end, { nargs = 0 })

create_cmd('LintToggle', function()
    if enabled then
      cmd.LintDisable()
    else
      cmd.LintEnable()
    end
  end, { nargs = 0 })
