return {
  "Bekaboo/dropbar.nvim",
  -- Requires nvim 0.10
  enabled = false,
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  keys = {
    {
      "gh",
      function()
        require("dropbar.api").pick()
      end,
      desc = { "Pick dropbar component hint [P]" },
    },
    {
      "gH",
      function()
        require("dropbar.api").fuzzy_find_toggle()
      end,
      desc = { "Search dropbar components" },
    },
  },
  opts = {},
}
