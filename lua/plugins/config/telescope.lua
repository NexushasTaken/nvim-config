return function()
  local map = vim.keymap.set;
  local scope = require("telescope");
  local themes = require("telescope.themes");
  local theme = "ivy2";

  function themes.get_ivy2(opts)
    opts = opts or {}

    local theme_opts = {
      theme = "ivy",

      sorting_strategy = "ascending",

      layout_strategy = "bottom_pane",
      layout_config = {
        height = function(_, _, max_lines)
          local max = 15;
          local lines = math.max(math.floor(max_lines/2), max);
          if lines < max then
            return max_lines;
          else
            return lines;
          end
        end,
      },

      border = true,
      borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
    }
    if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
      theme_opts.borderchars = {
        prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
        results = { "─", " ", " ", " ", "─", "─", " ", " " },
        preview = { "─", " ", "─", "│", "┬", "─", "─", "╰" },
      }
    end

    return vim.tbl_deep_extend("force", theme_opts, opts)
  end

  local prompt_cmd = function(name)
    return ":Telescope " .. name .. " theme="..theme.."<cr>";
  end

  map("n", "<leader>ff", prompt_cmd("find_files"), { noremap = true, });
  map("n", "<leader>fg", prompt_cmd("live_grep"), { noremap = true, });
  map("n", "<leader>fh", prompt_cmd("help_tags"), { noremap = true, });
  map("n", "<leader>fb", prompt_cmd("buffers"), { noremap = true, });
  map("n", "<leader>b",  prompt_cmd("buffers"), { noremap = true, });
  map("n", "<leader>ft", prompt_cmd("tags"), { noremap = true, });

  scope.setup({
    defaults = {
      layout_strategy = "vertical",
    },
  });
end
