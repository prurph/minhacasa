return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    -- Requires image magick and magick luarock. Install luarocks then:
    -- 1. Install magick: `luarocks install magick --lua-version 5.1
    -- 2. Add luarocks to package.path as seen in lua/config/options.lua with a few package.path = ... commands
    -- 3. Set up image.nvim as below. Must pass opts or it doesn't get initialized by LazyVim(?)
    { "3rd/image.nvim", opts = {} },
  },
  opts = {
    default_component_configs = {
      git_signs = {
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
    },
    source_selector = {
      winbar = true,
      statusline = true,
    },
    window = {
      mappings = {
        ["P"] = {
          "toggle_preview",
          config = { use_float = true, use_image_nvim = true },
        },
      },
    },
  },
}
