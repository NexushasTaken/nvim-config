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
        on_highlights = function(hl)
          hl.Todo = {
            fg = hl.Todo.bg,
            bg = hl.Normal.bg,
          };
          hl.Folded = {
            fg = hl.Comment.fg,
          };
        end,
      });

      vim.cmd.colorscheme("tokyonight-night");
    end,
  },
};
