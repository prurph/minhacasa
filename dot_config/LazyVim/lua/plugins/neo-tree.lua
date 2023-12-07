return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    -- Requires image magick and magick luarock. Install luarocks then:
    -- 1. Install magick: `luarocks install magick --lua-version 5.1
    -- 2. Add luarocks to package.path as seen in lua/config/options.lua with a few package.path = ... commands
    -- 3. Set up image.nvim as below. Must explicitly pass default opts or it doesn't get initialized properly.
    --
    "MunifTanjim/nui.nvim",
    {
      "3rd/image.nvim",
      opts = {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      },
    },
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
