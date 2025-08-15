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
          hl.Todo = {
            fg = hl.Todo.bg,
            bg = hl.Normal.bg,
          };
          hl.Folded = {
            fg = hl.Comment.fg,
          };
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
