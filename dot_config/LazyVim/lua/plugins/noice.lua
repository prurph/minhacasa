return {
  "folke/noice.nvim",
  opts = {
    presets = {
      -- Output cmdline results in a new window, not a popup
      cmdline_output_to_split = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            -- Duplicated from LazyVim defaults for documentation/completeness
            -- Matches some undo stuff
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },

            -- Matches some yank stuff. Lua does NOT support (more|fewer). It "pattern matches", not regexes.
            { find = "%d+ fewer lines?" },
            { find = "%d+ more lines?" },
            { find = "%d+ lines? yanked" },
          },
        },
        -- Shows right above statusbar. Much less intrusive than the full message popup.
        view = "mini",
      },
    },
  },
}
