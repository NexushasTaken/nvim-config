local kind_icons = {
  Value = "󰦨",

  Variable = "󰆦",
  Field = "󰜢",
  Property = "󰖷",
  EnumMember = "󰦨",

  Method = "󰊕",
  Function = "󰊕",

  Constructor = "󰒓",

  Keyword = "󰻾",
  Unit = "󰪚",
  TypeParameter = "󰬛",

  Struct = "󱡠",
  Class = "󱡠",
  Enum = "󰦨",
  Interface = "󱡠",
  Module = "󰅩",

  Reference = "󰬲",
  Constant = "󰏿",
  Event = "󱐋",

  Operator = "󰪚",

  Color = "󰏘",
  Text = "󰉿",
  Buffer = "",
  Snippet = "󱄽",
  Folder = "󰉋",
  File = "󰈔",
};

local kind_order = {
  "value",

  "variable",
  "field",
  "property",
  "enummember",

  "method",
  "function",

  "constructor",

  "keyword",
  "unit",
  "typeparameter",

  "struct",
  "class",
  "enum",
  "interface",
  "module",

  "reference",
  "constant",
  "event",
  "operator",

  "color",
  "text",
  "buffer",
  "snippet",
  "folder",
  "file",
}

--- @param a blink.cmp.CompletionItem
--- @param b blink.cmp.CompletionItem
local function predicate(a, b)
  local ka = kind_order[a.kind_name or ""] or 999
  local kb = kind_order[b.kind_name or ""] or 999

  if ka == kb then
    return (a.source_id or "") < (b.source_id or "")
  end

  return ka < kb
end

return {
  {
    "saghen/blink.cmp",
    version = "v1.4.*",
    lazy = false,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function()
          local lazy_load = function(snip)
            require("luasnip/loaders/from_vscode").lazy_load({
              paths = { vim.fn.stdpath("config") .. "/snippets/" .. snip, },
            });
          end;

          lazy_load("friendly-snippets");
          lazy_load("odoo-snippets");
        end,
      },
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

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      completion = {
        trigger = {
          show_on_keyword = false,
          show_on_trigger_character = false,
        },
        list = {
          selection = {
            auto_insert = false,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", "label_description", "source_name", gap = 1 } },
          }
        }
      },

      appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        -- Sets the fallback highlight groups to nvim-cmp"s highlight groups
        -- Useful for when your theme doesn"t support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to "mono" for "Nerd Font Mono" or "normal" for "Nerd Font"
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = kind_icons,
      },

      signature = { enabled = true, },

      keymap = {
        preset = "default",
        ["<Esc>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.hide();
            end
            return false;
          end,
          "fallback",
        },
        ["<C-e>"] = { "show", "hide" },
        ["<C-space>"] = { "show_documentation", "hide_documentation" },
        ["<Enter>"] = {
          "select_and_accept",
          "fallback",
        };

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next();
              return true;
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev();
              return true;
            end
          end,
          "snippet_backward",
          "fallback",
        },
        ["<C-q>"] = {
          "show_signature",
          "hide_signature",
          "fallback",
        },
        ["<C-p>"] = { function(cmp) cmp.scroll_documentation_up(1) end },
        ["<C-n>"] = { function(cmp) cmp.scroll_documentation_down(1) end },
        --["<C-a>"] = {
        --  function(cmp)
        --    print(vim.inspect(require("blink.cmp.types")));
        --  end,
        --  "fallback",
        --}
      },

      snippets = {
        preset = "luasnip",
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
      fuzzy = {
        sorts = {
          --predicate
        },
      },
    },
    opts_extend = { "sources.default" },
  },
};
