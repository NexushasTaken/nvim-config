function trailspace()
  local api = require("mini.trailspace");
  api.setup();
end

function indentscope()
  local api = require("mini.indentscope");
  api.setup({
    draw = {
      animation = api.gen_animation.none(),
    };
  });
end

function statusline()
  local api = require("mini.statusline");
  function active()
    local mode, mode_hl = MiniStatusline.section_mode({ })
    local git           = MiniStatusline.section_git({ })
    local diff          = MiniStatusline.section_diff({ })
    local diagnostics   = MiniStatusline.section_diagnostics({
      signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 "
    }});
    local lsp           = MiniStatusline.section_lsp({ })
    local filename      = MiniStatusline.section_filename({ })
    local fileinfo      = MiniStatusline.section_fileinfo({ })
    local location      = MiniStatusline.section_location({ })
    local search        = MiniStatusline.section_searchcount({ })

    return MiniStatusline.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = "MiniStatuslineDevinfo",  strings = { git, diff, diagnostics, lsp } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
      { hl = mode_hl,                  strings = { search, location } },
    })
  end

  api.setup({
    content = {
      active = active,
      inactive = nil,
    },
    use_icons = true,
  });
end

return function()
  indentscope();
  statusline();
  trailspace()

  local MiniDeps = require("mini.deps")
  --MiniDeps.add({
  --  source = "saghen/blink.cmp",
  --  depends = { "rafamadriz/friendly-snippets" },
  --  checkout = "v1.4.1", -- check releases for latest tag
  --})

  --local function build_blink(params)
  --  vim.notify("Building blink.cmp", vim.log.levels.INFO)
  --  local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path }):wait()
  --  if obj.code == 0 then
  --    vim.notify("Building blink.cmp done", vim.log.levels.INFO)
  --  else
  --    vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
  --  end
  --end

  --MiniDeps.add({
  --  source = "Saghen/blink.cmp",
  --  hooks = {
  --    post_install = build_blink,
  --    post_checkout = build_blink,
  --  },
  --})
end
