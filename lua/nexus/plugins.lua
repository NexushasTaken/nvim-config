local data_dir = vim.fn.stdpath("data")
local lazypath = data_dir .. "/lazy/lazy.nvim"

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
vim.opt.rtp:prepend(lazypath)

local opts = {
  lockfile = data_dir .. '/lazy-lock.json',
  install = { colorscheme = { "tokyonight" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip",
        "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
        "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
        "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax",
        "synmenu", "optwin", "compiler", "bugreport", "ftplugin",
      }
    }
  }
}

local function load_config(plug)
  return function()
    require('nexus.lazy-config.'..plug)
  end
end
local lazy = require'lazy'

lazy.setup({
  { -- Theme
    'folke/tokyonight.nvim',
    priority = 1000,
    config = load_config'colorscheme',
  },
  { -- Status line
    'itchyny/lightline.vim',
    config = load_config'lightline',
  },
  { -- Session Manager
    'natecraddock/sessions.nvim',
    lazy = true,
    cmd = { 'SessionsSave', 'SessionsLoad' },
    config = true,
    opts = {
      session_filepath =
        vim.fn.stdpath'data' .. '/sessions/'.. vim.fn.getcwd():gsub('/', '_'),
    },
  },
  { -- Highlight pairs
    'andymass/vim-matchup',
    priority = 999,
    config = load_config'matchup',
  },
  { -- Undo tree
    'mbbill/undotree',
    lazy = true,
    cmd = { 'UndotreeShow' },
    config = load_config'undotree',
  },
  { -- File browser
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd = { 'NvimTreeFocus' },
    config = load_config'nvim-tree',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- Icons
    }
  },
  { -- Commenter
    'numToStr/Comment.nvim',
    config = true,
  },
  { -- Auto close chars
    'windwp/nvim-autopairs',
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },
  { -- Relative numbers disabler
    'nkakouros-original/numbers.nvim',
    config = true,
    opts = {
      excluded_filetypes = {
        'nerdtree', 'unite', 'man', 'help',
      }
    }
  },
  { -- Auto close tag
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    ft = {
      'html', 'javascript', 'typescript', 'javascriptreact',
      'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
      'xml', 'php', 'markdown', 'glimmer','handlebars','hbs'
    },
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = { 'Telescope' },
    dependencies = {
      'nvim-lua/plenary.nvim', -- Some tools for Lua?
    }
  },
  { -- Fix tab formats
    'godlygeek/tabular',
    cmd = { 'Tabularize' },
    lazy = true,
  },
  {
    'folke/which-key.nvim',
    cmd = { 'WhichKey' },
    lazy = true,
    opt = {
      popup_mappings = {
        scroll_up = "<c-p>",
        scroll_down = "<c-n>",
      },
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-path',
    }
  },
  {
    'lewis6991/impatient.nvim',
    config = function()
      require'impatient'.enable_profile()
    end
  },

  { -- Lsp Manager
    'VonHeikemen/lsp-zero.nvim',
    cmd = { 'LspStart' },
    lazy = true,
    config = load_config'lsp-zero',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',             -- Required
      'williamboman/mason-lspconfig.nvim', -- Optional

      -- Autocompletion
      'hrsh7th/nvim-cmp',         -- Required
      'hrsh7th/cmp-nvim-lsp',     -- Required
      'hrsh7th/cmp-buffer',       -- Optional
      'hrsh7th/cmp-path',         -- Optional
      'saadparwaiz1/cmp_luasnip', -- Optional
      'hrsh7th/cmp-nvim-lua',     -- Optional

      -- Snippets
      'L3MON4D3/LuaSnip',             -- Required
      'rafamadriz/friendly-snippets', -- Optional
    },
  },


  'iamcco/markdown-preview.nvim',
  'manzeloth/live-server', -- Live server
  'stevearc/vim-arduino', -- Arduino
  'jghauser/mkdir.nvim', -- Make dirs when saving files
  'sheerun/vim-polyglot', -- Better language support
  'kyazdani42/nvim-web-devicons', -- Icons

  -- I might need these
  -- "ahmedkhalf/project.nvim",
}, opts)

--[[
-- Install your plugins here
return packer.startup(function(use)
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }
	use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }

	-- Cmp 
  use { "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions
	use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
	use { "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" }
	use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

	-- Snippets
  use { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" } -- a bunch of snippets to use

	-- LSP
	use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
  use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"} -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
	use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  -- use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

	-- Telescope
	use { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" }

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
	}

	-- Git
	use { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" }
end) ]]
