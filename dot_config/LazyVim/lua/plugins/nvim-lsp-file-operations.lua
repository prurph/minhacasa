-- Order plugins load is important: nvim-lsp-file-operations must depend on neo-tree and not vice-versa
return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    opts = {},
  },
}
