return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      -- If no message available on hover trigger, show nothing. Important when there are multiple
      -- LSPs active (e.g. in a JSX file).
      hover = {
        silent = true,
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = false, -- Use C-K to show signature help, do *not* pop up automatically
          luasnip = true,
          throttle = 50,
        },
      },
    },
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

            -- Matches yank and :s/foo/bar/ stuff. Lua does NOT support (more|fewer). It "pattern matches", not regexes.
            { find = "%d+ fewer lines?" },
            { find = "%d+ more lines?" },
            { find = "%d+ lines? yanked" },
            { find = "%d+ substitutions on %d+ lines?" },
          },
        },
        -- Shows right above statusbar. Much less intrusive than the full message popup.
        view = "mini",
      },
    },
  },
}
