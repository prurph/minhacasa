return {
  "neovim/nvim-lspconfig",
  opts = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          -- Pickup new modules, etc. for nvim 0.9
          -- https://www.reddit.com/r/neovim/comments/179vv49/nvim_golang_lsp_not_detecting_newly_installed/
          dynamicRegistration = true,
        },
      },
    },
  },
}
