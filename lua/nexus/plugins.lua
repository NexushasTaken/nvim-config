local function load_config(plug)
  return function()
    require('nexus.lazy-config.'..plug)
  end
end

local util = require'utils'

return {
  { -- Theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = load_config'tokyonight',
  },
  { -- Status line
    'itchyny/lightline.vim',
    config = load_config'lightline',
  },
  { -- Session Manager
    'natecraddock/sessions.nvim',
    config = true,
    opts = {
      session_filepath = vim.fn.stdpath'data' .. '/sessions/'.. util.cwd(true),
    },
  },
  { -- Highlight pairs
    'andymass/vim-matchup',
    lazy = false,
    priority = 999,
    config = load_config'matchup',
  },
  { -- Undo tree
    'mbbill/undotree',
    config = load_config'undotree',
  },
  { -- File browser
    'nvim-tree/nvim-tree.lua',
    config = load_config'tree',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- Icons
    }
  },
  { -- Auto close tag
    'windwp/nvim-ts-autotag',
    config = true,
  },
  { -- Auto close chars
    'windwp/nvim-autopairs',
    config = true,
  },
  {
    'nkakouros-original/numbers.nvim', -- Relative numbers disabler
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Some tools for Lua?
    }
  },

  { -- Lsp Manager
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    config = load_config'lsp-zero',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',             -- Required
      'williamboman/mason.nvim',           -- Optional
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
    keys = {
      {
        '<leader>gl',
        function()
          require'lsp-zero'
          vim.cmd'LspStart'
          print'Lsp Started'
        end,
        desc = "Start Lsp",
      }
    }
  },
  'nvim-treesitter/nvim-treesitter', -- Better syntax highlighting
  'manzeloth/live-server', -- Live server
  'stevearc/vim-arduino', -- Arduino
  'godlygeek/tabular', -- Fix tab formats
  'jghauser/mkdir.nvim', -- Make dirs when saving files
  'sheerun/vim-polyglot', -- Better language support
  'kyazdani42/nvim-web-devicons', -- Icons
}
