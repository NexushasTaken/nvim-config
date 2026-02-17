return {
  { -- Theme
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 100,
    opts = function()
      require("tokyonight").setup({
        style = "night",
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_highlights = function(hl, c)
          local colors = require("tokyonight.colors").setup()
          local util = require("tokyonight.util")
          hl.Todo = {
            fg = hl.Todo.bg,
            bg = hl.Normal.bg,
          };
          hl.Folded = {
            fg = hl.Comment.fg,
          };
          hl.RenderMarkdownCodeInline = {
            bg = util.blend(colors.blue, 0.1, hl.Normal.bg),
            fg = colors.blue,
          }
          for _, group in ipairs({
            "DiagnosticUnderlineError",
            "DiagnosticUnderlineWarn",
            "DiagnosticUnderlineInfo",
            "DiagnosticUnderlineHint",
          }) do
            hl[group] = { underline = true, undercurl = false, sp = c.red };
          end
        end,
      });

      vim.cmd.colorscheme("tokyonight-night");
    end,
  },
};
