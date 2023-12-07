-- Order plugins load is important: nvim-lsp-file-operations must depend on neo-tree and not vice-versa
return {
  {
    "antosha417/nvim-lsp-file-operations",
    -- Disabled because it causes nvim to exit with status 134, which makes chezmoi always report as such.
    -- https://github.com/antosha417/nvim-lsp-file-operations/issues/24
    -- The issue doesn't seem to be with this plugin per se, but something with the way everything gets
    -- loaded in LazyVim seems to cause 3rd/image.nvim to work properly (images can be previewed) but
    -- nvim always exits with 134.
    --
    -- I'm able to repro this behavior _without_ nvim-lsp-file-operations by passing an empty opts table
    -- to 3rd/image.nvim, so I wonder if somehow the above setup causes that to happen.
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    opts = {
      debug = true,
    },
  },
}
