return {
  {
    "mason-org/mason.nvim",
    cmd = { "LspStart" },
    config = function()
      require("mason").setup({
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
        },
        log_level = vim.log.levels.INFO,
      });
      require("plugins.config.lsp");
      require("mason-lspconfig").setup();
    end,

    dependencies = {
      {
        -- Bridges mason with nvim-lspconfig
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
          {
            -- Main LSP config plugin
            "neovim/nvim-lspconfig",
            dependencies = {
              "nvimtools/none-ls.nvim",
              "stevearc/vim-arduino",
              --[[ Uncomment these if needed
              {
                "mfussenegger/nvim-lint",
                config = load_config("lint"),
              },
              {
                "simrat39/symbols-outline.nvim",
                config = load_config("symbols-outline"),
              },
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
              }, ]]--
            },
          },
        },
      },
    },
  },
};

--[[ return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nexus.lsp");
    end,
    cmd = { "LspStart" },
    dependencies = {
      "stevearc/vim-arduino",
      "nvimtools/none-ls.nvim",
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
        },
      },
      {
        "mfussenegger/nvim-lint",
        config = load_config("lint"),
      },
      {
        "simrat39/symbols-outline.nvim",
        config = load_config("symbols-outline"),
      },
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
    },
  },
}; ]]
