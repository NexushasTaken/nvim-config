local cmp = require'cmp'
local luasnip = require'luasnip'

require('luasnip/loaders/from_vscode').lazy_load({
  paths = { vim.fn.stdpath'config' .. '/friendly-snippets' }
})

local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text          = '',
  Method        = 'm',
  Function      = '',
  Constructor   = '',
  Field         = '',
  Variable      = '',
  Class         = '',
  Interface     = '',
  Module        = '',
  Property      = '',
  Unit          = '',
  Value         = '',
  Enum          = '',
  Keyword       = '',
  Snippet       = '',
  Color         = '',
  File          = '',
  Reference     = '',
  Folder        = '',
  EnumMember    = '',
  Constant      = '',
  Struct        = '',
  Event         = '',
  Operator      = '',
  TypeParameter = '',
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  enabled = function()
    -- disable completion in comments
    local context = require'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-Space>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        buffer = '[Buffer]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  window = {
    documentation = {
      max_width = 0,
      max_height = 0,
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  completion = {
    autocomplete = false,
  }
}