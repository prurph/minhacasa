return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(mode)
            return mode:sub(1, 1)
          end,
        },
      },
      lualine_y = {
        -- Remove LazyVim default that contains "progress" (% of file)
        { "location", padding = { left = 0, right = 1 } },
      },
    },
  },
}
