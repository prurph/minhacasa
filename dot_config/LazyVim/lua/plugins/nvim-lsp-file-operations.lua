-- Order plugins load is important: nvim-lsp-file-operations must depend on neo-tree and not vice-versa
return {
  {
    "antosha417/nvim-lsp-file-operations",
    -- Disabled because it causes nvim to exit with status 134, which makes chezmoi always report as such.
    -- https://github.com/antosha417/nvim-lsp-file-operations/issues/24
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
