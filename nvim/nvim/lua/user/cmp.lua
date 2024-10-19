local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path",
      event = "InsertEnter",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/cmp-calc"
    },
    -- {
    --   "hrsh7th/cmp-nvim-lua",
    -- },
  },
}


function M.config()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/user/snippets/friendly-snippets/" } })
  require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/user/snippets/snippets/" } })

  vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })

    local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local icons = require "user.icons"

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
   -- ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
   -- ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
   -- ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
   -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
   -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
   -- ["<C-e>"] = cmp.mapping {
   --   i = cmp.mapping.abort(),
   --   c = cmp.mapping.close(),
   -- },
      ["<Up>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Down>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Left>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Right>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
--      ["<Home>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
--      ["<End>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
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
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },

    formating = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
        })[entry.source.name]

        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      -- { name = "cmp_tabnine" },
      -- { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
    experimental = {
      ghost_text = false,
    },
  }
end

return M
