return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "gb", "<Cmd>BufferLinePick<CR>", desc = "Buffer hints [P]" },
    { "gB", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer with hints [P]" },
    { "<M-h>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer next [P]" },
    { "<M-l>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next [P]" },
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
