return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "gb", "<Cmd>BufferLinePick<CR>", desc = "Buffer hints [P]" },
    { "gB", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer with hints [P]" },
  },
  opts = {
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          text = " Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
