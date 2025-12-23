return {
  { -- Hop
    "phaazon/hop.nvim",
    config = function()
      local map = vim.keymap.set;
      local hop = require("hop");
      hop.setup();

      local hop_map = function(suffix, command)
        map("n", "<leader>h"..suffix, vim.cmd[command], { desc = command, });
      end;
      hop_map("w", "HopWord");
      hop_map("p", "HopPattern");
      hop_map("l", "HopLine");
      hop_map("s", "HopLineStart");
      hop_map("v", "HopVertical");
      hop_map("a", "HopAnywhere");
      hop_map("cj", "HopChar1");
      hop_map("ck", "HopChar2");
    end,
    keys = "<leader>h",
  },

  { -- Hard Time
    "m4xshen/hardtime.nvim",
    enabled = false,
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  { -- Highlight pairs
    "andymass/vim-matchup",
    lazy = false,
    config = function()
      local html_conf = {
        tagnameonly = 1,
        nolists = 1,
      };
      vim.g.matchup_matchpref = {
        html = html_conf,
        xml = html_conf,
      };
      vim.g.matchup_matchparen_deferred = 1;
      vim.g.matchup_matchparen_offscreen = {};
      vim.g.matchup_matchparen_nomode = "i";
      vim.g.matchup_matchparen_pumvisible = 0;
    end,
  },

  { -- Aerial
    "stevearc/aerial.nvim",
    lazy = false,
    opts = {
      show_guides = true,
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },

  { -- Lean
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean", },

    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      -- you also will likely want nvim-cmp or some completion engine
    },

    -- see details below for full configuration options
    opts = {
      lsp = {},
      mappings = true,
    },
  },

  { -- Colorizer
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    lazy = false,
    opts = {
      user_default_options = {
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn   = true,
        hsl_fn   = true,
        css      = true,
        css_fn   = true,
        tailwind = true,
        tailwind_opts = {
          update_names = true,
        },
        sass = {
          enable = true,
          parsers = { "css" }
        },
        mode = "foreground",
      }
    },
  },

  { -- Undo tree
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    config = function()
      local g = vim.g;
      if g.loaded_undotree == 1 then
        g.undotree_WindowLayout = 2;
        g.undotree_ShortIndicators = 1;
        g.undotree_DiffAutoOpen = 1;
        g.undotree_SetFocusWhenToggle = 1;
        g.undotree_HelpLine = 0;
      end
    end,
  },

  { -- Oil
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {
      columns = {
        "permissions",
        "size",
        "icon",
      },
    },
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { -- Relative numbers disabler
    "nkakouros-original/numbers.nvim",
    keys = { "i", },
    config = true,
    opts = {
      excluded_filetypes = {
        "man", "unite", "tagbar", "startify",
        "gundo", "vimshell", "w3m", "nerdtree",
        "Mundo", "MundoDiff",
      },
    },
  },

  { -- Rainbow CSV
    "mechatroner/rainbow_csv",
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },

  { -- Orgmode TODO: use https://github.com/nvim-neorg/neorg
    "nvim-orgmode/orgmode",
    enabled = true,
    event = "VeryLazy",
    ft = { "org" },
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
  },

  { -- Render markdown
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim" -- if you use the mini.nvim suite
    },
    opts = {},
  },

  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    opts = {},
  },

  { -- Which key
    "folke/which-key.nvim",
    cmd = { "WhichKey", },
    config = require("plugins.config.which-key"),
  },

  { -- Vim fugitive
    "tpope/vim-fugitive",
    enabled = false,
    lazy = false,
  },

  { -- Fix tab formats
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },

  { -- Bracey
    "turbio/bracey.vim",
    ft = require("config.global").web_extensions,
  },

  { -- Emmet
    "mattn/emmet-vim",
    ft = require("config.global").web_extensions,
  },

  { -- Markdown preview
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  { -- Make dirs when saving files
    "jghauser/mkdir.nvim",
    lazy = false,
  },

  { -- Text case
    "johmsalas/text-case.nvim",
    lazy = false,
    config = true,
  },

  { -- Better language support
    "sheerun/vim-polyglot",
  },

  { -- Mini
    "echasnovski/mini.nvim",
    lazy = false,
    config = require("plugins.config.mini"),
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = 'typst',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  {
    "HiPhish/info.vim",
    lazy = false,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },
};
