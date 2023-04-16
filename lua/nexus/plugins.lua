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
  defaults = { lazy = true, },
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
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  ui = {
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
    },
  },
}

local function load_config(plug)
  return function()
    require('nexus.lazy-config.' .. plug)
  end
end
local lazy = require 'lazy'
local web_extensions = {
  'html', 'javascript', 'typescript', 'javascriptreact',
  'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
  'xml', 'php', 'markdown', 'glimmer', 'handlebars', 'hbs'
}

lazy.setup({
  {
    -- Theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 100,
    config = load_config 'colorscheme',
  },
  {
    -- Status line
    'itchyny/lightline.vim',
    lazy = false,
    priority = 99,
    config = load_config 'lightline',
  },
  {
    -- Relative numbers disabler
    'nkakouros-original/numbers.nvim',
    lazy = false,
    config = true,
    priority = 98,
    opts = {
      excluded_filetypes = {
        'nerdtree', 'unite', 'man', 'help',
      }
    }
  },
  {
   -- Highlight pairs
    'andymass/vim-matchup',
    lazy = false,
    config = load_config 'matchup',
  },

  {
    -- Session Manager
    'natecraddock/sessions.nvim',
    cmd = { 'SessionsSave', 'SessionsLoad' },
    config = true,
    opts = {
      session_filepath =
          vim.fn.stdpath 'data' .. '/sessions/' .. vim.fn.getcwd():gsub('/', '_'),
    },
  },
  {
    -- Undo tree
    'mbbill/undotree',
    cmd = { 'UndotreeToggle' },
    config = load_config 'undotree',
  },
  {
    -- File browser
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeFocus' },
    config = load_config 'nvim-tree',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- Icons
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
      'nvim-lua/plenary.nvim', -- Some tools for Lua?
    }
  },
  {
    -- Fix tab formats
    'godlygeek/tabular',
    cmd = { 'Tabularize' },
  },
  {
    'folke/which-key.nvim',
    cmd = { 'WhichKey' },
    opt = {
      popup_mappings = {
        scroll_up = "<c-p>",
        scroll_down = "<c-n>",
      },
    }
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
  },
  {
    -- Live server
    'manzeloth/live-server',
    ft = web_extensions,
  },
  {
    -- Make dirs when saving files
    'jghauser/mkdir.nvim',
    lazy = false,
  },
  {
    -- Better language support
    'sheerun/vim-polyglot',
    lazy = false,
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
  },
  {
    'moll/vim-bbye',
    lazy = false,
  },
  {
    -- Auto close chars
    'windwp/nvim-autopairs',
    lazy = false,
    config = true,
    opts = {
      excluded_filetypes = {
        'TelescopePrompt', 'vim',
      }
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'nexus.lsp'
    end,
    cmd = { 'LspStart' },
    dependencies = {
      'stevearc/vim-arduino',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'ray-x/lsp_signature.nvim',
        config = true,
        opts = {
          hint_enable = false,
          handler_opts = {
            border = 'none',
          },
        },
      },
      {
        -- Commenter
        'numToStr/Comment.nvim',
        config = true,
      },
      {
        -- Auto close tag
        'windwp/nvim-ts-autotag',
        ft = web_extensions,
        config = true,
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
        },
      },
      {
        'hrsh7th/nvim-cmp',
        config = function()
          require 'nexus.lsp.cmp'
        end,
        dependencies = {
          'L3MON4D3/LuaSnip', -- Required
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          -- 'rafamadriz/friendly-snippets',
          'saadparwaiz1/cmp_luasnip',
          'hrsh7th/cmp-nvim-lua',
        }
      },
      {
        'nvim-treesitter/nvim-treesitter',
        config = load_config 'treesitter',
      }
    }
  },
}, opts)
