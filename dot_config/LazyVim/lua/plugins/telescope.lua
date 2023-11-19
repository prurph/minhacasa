local actions = require("telescope.actions")
local trouble_telescope = require("trouble.providers.telescope")
local trouble = require("trouble")

local function send_to_qflist(bufnr)
  actions.smart_send_to_qflist(bufnr)
  trouble.open("quickfix")
end

local function send_to_loclist(bufnr)
  actions.smart_send_to_loclist(bufnr)
  trouble.open("loclist")
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "benfowler/telescope-luasnip.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
    end,
    opts = {},
  },
  keys = {
    -- LazyVim default uses sort_mru which often selects worse matches and is infuriating 😅
    { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix [P]" },
    { "<leader>sQ", "<cmd>Telescope quickfix<cr>", desc = "Quickfix history [P]" },
    { "<leader>sl", "<cmd>Telescope quickfix<cr>", desc = "Search loclist [P]" },
    { "<leader>sp", "<cmd>Telescope notifications<cr>", desc = "Notifications [P]" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-n>"] = actions.cycle_history_next,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-h>"] = actions.preview_scrolling_left,
          ["<C-l>"] = actions.preview_scrolling_right,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.preview_scrolling_up,

          ["<M-t>"] = trouble_telescope.smart_open_with_trouble,
          ["<M-q>"] = send_to_qflist,
          ["<M-c>"] = send_to_loclist,
        },
        n = {
          ["<M-t>"] = trouble_telescope.smart_open_with_trouble,
          ["<M-q>"] = send_to_qflist,
          ["<M-c>"] = send_to_loclist,
        },
      },
    },
  },
}
