local fn = vim.fn;
local cmp = require("cmp");
local luasnip = require("luasnip");

local lazy_load = function(snip)
  require("luasnip/loaders/from_vscode").lazy_load({
    paths = { fn.stdpath("config") .. "/snippets/" .. snip, },
  });
end;

lazy_load("friendly-snippets");
lazy_load("odoo-snippets");

local check_backspace = function()
  local col = fn.col(".") - 1;
  return col == 0 or fn.getline("."):sub(col, col):match("%s");
end;

-- 󰀪פּ ﯟ  󰂚 some other good icons
local kind_icons = {
  Text          = "󰉿", -- nf-md-text
  Method        = "󰆧", -- nf-md-function_variant
  Function      = "󰊕", -- nf-md-function
  Constructor   = "", -- nf-oct-tools
  Field         = "󰜢", -- nf-md-field
  Variable      = "󰀫", -- nf-md-variable
  Class         = "󰠱", -- nf-md-language_cpp
  Interface     = "", -- nf-fa-sitemap (fallback)
  Module        = "󰏗", -- nf-md-package_variant
  Property      = "󰜢", -- nf-md-field (reuse)
  Unit          = "", -- nf-dev-terminal (fallback)
  Value         = "󰎠", -- nf-md-format_list_numbered
  Enum          = "", -- nf-fa-list_ol
  Keyword       = "󰌋", -- nf-md-keyboard
  Snippet       = "", -- nf-fa-scissors
  Color         = "󰏘", -- nf-md-palette
  File          = "󰈙", -- nf-md-file_document
  Reference     = "󰈇", -- nf-md-link_variant
  Folder        = "󰉋", -- nf-md-folder
  EnumMember    = "󰘦", -- nf-md-format_list_bulleted
  Constant      = "󰏿", -- nf-md-alpha
  Struct        = "󰙅", -- nf-md-vector_square
  Event         = "", -- nf-fa-bolt
  Operator      = "󰆕", -- nf-md-code_not_equal
  TypeParameter = "󰊄", -- nf-md-code_tags
}

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require("cmp.config.context");
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == "c" then
      return true;
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment");
    end
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body); -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<ESC>"] = cmp.mapping({
      i = function(fallback)
        if luasnip.in_snippet() then
          luasnip.unlink_current();
        elseif cmp.visible() then
          cmp.abort();
        end
        fallback();
      end
    }),
    ["<C-e>"] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort();
        else
          cmp.complete();
        end
      end,
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false, }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, });
      elseif luasnip.jumpable(1) then
        luasnip.jump(1);
      elseif check_backspace() then
        fallback();
      else
        fallback();
      end
    end, { "i", "s", }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select, });
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1);
      else
        fallback();
      end
    end, { "i", "s", }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu", },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lua = "[Lua]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name];
      return vim_item;
    end,
  },
  sources = {
    { name = "nvim_lua", },
    { name = "nvim_lsp", },
    { name = "luasnip", },
    { name = "path", },
    { name = "buffer", },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Select,
    select = false,
  },
  window = {
    documentation = cmp.config.disable,
  },
  experimental = {
    ghost_text = false,
  },
  completion = {
    autocomplete = false,
  },
});
