return {
  "benfowler/telescope-luasnip.nvim",
  lazy = true,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>sz", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
  },
  config = function()
    require("telescope").load_extension("luasnip")
  end,
}
