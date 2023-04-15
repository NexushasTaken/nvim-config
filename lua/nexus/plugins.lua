local function load_config(plug)
  return function()
    require('nexus.lazy-config.'..plug)
  end
end

local util = require'utils'

return {
  { -- Theme
    'folke/tokyonight.nvim',
    priority = 1000,
    config = load_config'tokyonight',
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
      session_filepath = vim.fn.stdpath'data' .. '/sessions/'.. util.cwd(true),
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
    config = load_config'tree',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- Icons
    }
  },
  {
    'numToStr/Comment.nvim',
    config = load_config'comment',
  },
  { -- Auto close chars
    'windwp/nvim-autopairs',
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
    lazy = true,
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
    config = load_config'which-key',
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

  --[[ {
    'jose-elias-alvarez/null-ls.nvim',
    config = load_config'null-ls',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
    }
  }, ]]


  'nvim-treesitter/nvim-treesitter', -- Better syntax highlighting
  'iamcco/markdown-preview.nvim',
  'manzeloth/live-server', -- Live server
  'stevearc/vim-arduino', -- Arduino
  'jghauser/mkdir.nvim', -- Make dirs when saving files
  'sheerun/vim-polyglot', -- Better language support
  'kyazdani42/nvim-web-devicons', -- Icons
}
