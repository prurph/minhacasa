-- By default <leader>xL/xQ use Trouble, while lowercase use builtin. Remove
-- the capital bindings here; ../plugins/trouble.lua rebinds the lowercase
-- to always use trouble
return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    { "<leader>xs", "<cmd>TroubleToggle telescope<cr>", desc = "Telescope List (Trouble)" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References (Trouble)" },
    -- Overwrite these to use trouble instead of built-in quickfix
    { "<leader>xL", false },
    { "<leader>xQ", false },
  },
}
