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
    hl["@vector.x"] = {
      fg = "#f7768e",
    };
    hl["@vector.y"] = {
      fg = "#9ece6a",
    };
    hl["@vector.z"] = {
      fg = "#7aa2f7",
    };
    hl["@vector.w"] = {
      fg = "#9d7cd8",
    };
    hl["@color.red"] = {
      fg = "#f7768e",
    };
    hl["@color.green"] = {
      fg = "#9ece6a",
    };
    hl["@color.blue"] = {
      fg = "#7aa2f7",
    };
    hl["@color.alpha"] = {
      fg = "#545c7e",
    };
  end,
});

vim.cmd.colorscheme("tokyonight-night");
