return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      symbols = {
        -- Change type
        added = "✚",
        deleted = "✖",
        modified = "",
        renamed = "󰁕",
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
    source_selector = {
      winbar = true,
      statusline = true,
    },
  },
}
