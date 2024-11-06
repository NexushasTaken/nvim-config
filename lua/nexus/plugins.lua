local data_dir = vim.fn.stdpath("data");
local lazypath = data_dir .. "/lazy/lazy.nvim";

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath);

local opts = {
  defaults = { lazy = true, },
  lockfile = data_dir .. "/lazy-lock.json",
  install = { colorscheme = { "tokyonight", }, },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip",
        "logipat", --[[ "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", ]]
        "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
        "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax",
        "synmenu", "optwin", "compiler", "bugreport", "ftplugin", "spellfile"
      },
    },
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  ui = {
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
    },
  },
  dev = {
    path = "~/workspace/vim_plugins",
  },
};

local load_config = function(plug, as_opt)
  if as_opt then
    return require("nexus.lazy-config." .. plug);
  else
    return function()
      require("nexus.lazy-config." .. plug);
    end
  end
end

local lazy = require("lazy");
local web_extensions = {
  "html", "javascript", "typescript", "javascriptreact",
  "typescriptreact", "svelte", "vue", "tsx", "jsx", "rescript",
  "xml", "php", "markdown", "glimmer", "handlebars", "hbs",
};

lazy.setup({
  { -- Theme
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 100,
    config = load_config("colorscheme"),
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 99,
    config = load_config("lualine"),
    dependencies = { "nvim-tree/nvim-web-devicons", },
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

  { -- Highlight pairs
    "andymass/vim-matchup",
    lazy = false,
    config = load_config("matchup"),
  },

  { -- File browser
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFocus" },
    config = load_config("nvim-tree"),
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Icons
    },
  },

  { -- Auto close chars
    "windwp/nvim-autopairs",
    keys = {
      { "{", mode = "i" },
      { "[", mode = "i" },
      { "(", mode = "i" },
      { '"', mode = "i" },
      { "'", mode = "i" },
    },
    config = load_config("autopairs"),
  },

  {
    "kylechui/nvim-surround",
    keys = {
      { "<C-g>s", mode = "i", },
      { "<C-g>S", mode = "i", },
      { "ys", mode = "n", },
      { "yss", mode = "n", },
      { "yS", mode = "n", },
      { "ySS", mode = "n", },
      { "S", mode = "v", },
      { "gS", mode = "v", },
      "ds","cs",
    },
    config = true,
  },

  { -- Commenter
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = load_config("comment"),
  },

  { -- Undo tree
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    config = load_config("undotree"),
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = load_config("telescope"),
    dependencies = {
      "nvim-lua/plenary.nvim", -- Some tools for Lua?
    },
  },

  { -- Fix tab formats
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = load_config("todo-comments", true),
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    cmd = { "WhichKey", },
    config = load_config("which-key"),
  },

  {
    "echasnovski/mini.nvim",
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
  },

  { -- Make dirs when saving files
    "jghauser/mkdir.nvim",
    lazy = false,
  },

  { -- Better language support
    "sheerun/vim-polyglot",
  },

  {
    "johmsalas/text-case.nvim",
    lazy = false,
  },

  {
    "tpope/vim-fugitive",
    enabled = false,
    lazy = false,
  },

  { -- Buffer remover
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
  },

  {
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

  {
    "turbio/bracey.vim",
    ft = web_extensions,
  },

  {
    "phaazon/hop.nvim",
    config = load_config("hop"),
    keys = "<leader>h",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      { -- Auto close tag
        "windwp/nvim-ts-autotag",
        ft = web_extensions,
      },
    },
    config = load_config("treesitter"),
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
    config = load_config("playground"),
  },

  {
    'stevearc/oil.nvim',
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

  {
    "mattn/emmet-vim",
    ft = web_extensions,
  },

  {
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

    config = load_config("lean"),
  },

  {
    "stevearc/conform.nvim",
    lazy = false,
    config = load_config("conform"),
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = load_config("hardtime"),
  },

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = load_config("orgmode"),
  },

  { -- Debugger
    "rcarriga/nvim-dap-ui",
    keys = {
      "<F2>",
      "<F3>",
      "<F4>",
      "<F5>",
      "<F6>",
      "<F7>",
      "<F8>",
      "<F9>",
    },
    cmd = {
      "DapContinue",
      "DapDisconnect",
      "DapEval",
      "DapInstall",
      "DapLoadLaunchJSON",
      "DapNew",
      "DapRestartFrame",
      "DapSetLogLevel",
      "DapShowLog",
      "DapStepInto",
      "DapStepOut",
      "DapStepOver",
      "DapTerminate",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapUninstall",
    },
    config = load_config("dap-ui"),
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = load_config("dap-mason"),
        dependencies = {
          "williamboman/mason.nvim",
          "mfussenegger/nvim-dap",
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nexus.lsp");
    end,
    cmd = { "LspStart" },
    dependencies = {
      "stevearc/vim-arduino",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      {
        "mfussenegger/nvim-lint",
        config = load_config("lint"),
      },
      --[[ {
        "ray-x/lsp_signature.nvim",
        enabled = false,
        config = true,
        opts = {
          hint_enable = false,
          handler_opts = {
            border = "none",
          },
        },
      }, ]]
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("nexus.lsp.cmp");
        end,
        dependencies = {
          "L3MON4D3/LuaSnip", -- Required
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          -- "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-nvim-lua",
        }
      },
      {
        "simrat39/symbols-outline.nvim",
        config = load_config("symbols-outline"),
      },
    }
  },
}, opts);
