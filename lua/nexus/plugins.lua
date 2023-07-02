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
        "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
        "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
        "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax",
        "synmenu", "optwin", "compiler", "bugreport", "ftplugin",
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
};

local load_config = function(plug)
  return function()
    require("nexus.lazy-config." .. plug);
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
  { -- Status line
    "itchyny/lightline.vim",
    lazy = false,
    priority = 99,
    config = load_config("lightline"),
  },
  { -- Relative numbers disabler
    "nkakouros-original/numbers.nvim",
    lazy = false,
    config = true,
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
      "kyazdani42/nvim-web-devicons", -- Icons
    },
  },
  { -- Auto close chars
    "windwp/nvim-autopairs",
    lazy = false,
    config = load_config("autopairs"),
  },
  {
    "kylechui/nvim-surround",
    lazy = false,
    config = true,
  },
  { -- Commenter
    "numToStr/Comment.nvim",
    lazy = false,
    config = true,
  },

  { -- Undo tree
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    config = load_config("undotree"),
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- Some tools for Lua?
    },
  },
  { -- Fix tab formats
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    config = load_config('which-key'),
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
    lazy = false,
  },
  {
    "tpope/vim-fugitive",
    enabled = false,
    lazy = false,
  },
  { -- Buffer remover
    "moll/vim-bbye",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nexus.lsp")
    end,
    cmd = { "LspStart" },
    dependencies = {
      "stevearc/vim-arduino",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "ray-x/lsp_signature.nvim",
        enabled = false,
        config = true,
        opts = {
          hint_enable = false,
          handler_opts = {
            border = "none",
          },
        },
      },
      { -- Auto close tag
        "windwp/nvim-ts-autotag",
        ft = web_extensions,
        config = true,
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
      },
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("nexus.lsp.cmp")
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
        "nvim-treesitter/nvim-treesitter",
        config = load_config("treesitter"),
      },
      -- TODO Add null-ls plugin.
    }
  },
}, opts);
