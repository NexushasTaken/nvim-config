return {
  {
    "saghen/blink.cmp",
    version = "v1.4.*",
    lazy = false,
    dependencies = {
      "L3MON4D3/LuaSnip",
      -- "rafamadriz/friendly-snippets",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },

      appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        -- Sets the fallback highlight groups to nvim-cmp"s highlight groups
        -- Useful for when your theme doesn"t support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to "mono" for "Nerd Font Mono" or "normal" for "Nerd Font"
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },

      keymap = {
        preset = "default",
        ["<ESC>"] = { function(cmp)
            if cmp.is_visible() then
              cmp.cancel();
            end
            return;
          end,
          "fallback",
        },
        ["<C-e>"] = { "show", "hide" },
        ["<C-space>"] = { "show_documentation", "hide_documentation" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next();
              return true;
            end
          end,
           "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev();
              return true;
            end
          end,
          "fallback",
        },
        ["<C-q>"] = {
          function(cmp)
            print(vim.inspect(cmp));
          end,
        },
      },

      sources = {
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer"
        },

        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
};
