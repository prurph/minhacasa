local cmp = require("cmp")
local types = require("cmp.types")

-- Goals with this cmp setup:
--   - Don't cmp in comments
--   - Don't auto-select; allows <CR> to work normally
--   - Pressing <Tab>/<S-Tab> cycles through matches
--   - Snippets work

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  opts = {
    -- Don't autoselect
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    enabled = function()
      -- disable completion in comments
      local context = require("cmp.config.context")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
    preselect = types.cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-y>"] = cmp.mapping.scroll_docs(-4),
      ["<C-e>"] = cmp.mapping.scroll_docs(4),

      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = cmp.mapping.abort(),

      -- <CR> for newline if nothing is selected
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),

      -- Super-tab like mapping
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
      -- NB: trying toplevel require luasnip here didn't work snippets didn't appear in cmp
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require("luasnip")
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- NB: trying toplevel require luasnip here didn't work snippets didn't appear in cmp
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require("luasnip")
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  },
}
