return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    dependencies = {
      { -- Auto close tag
        "windwp/nvim-ts-autotag",
        ft = require("config.global").web_extensions,
      },
    },
    config = require("plugins.config.treesitter"),
  },

  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlayground",
      "TSPlaygroundToggle",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    }
  },
};
