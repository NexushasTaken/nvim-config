require'tokyonight'.setup{
  style = 'night',
  styles = {
    comments = { italic = false },
    keywords = { italic = false }
  },
  on_highlights = function(hl)
    hl.Todo = {
      fg = hl.Todo.bg,
      bg = "None",
    }
  end,
}
vim.cmd.colorscheme'tokyonight-night'
