return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.tbl_deep_extend("force", opts.capabilities, {
        workspace = {
          didChangeWatchedFiles = {
            -- Pickup new modules, etc. for nvim 0.9.
            -- https://www.reddit.com/r/neovim/comments/179vv49/nvim_golang_lsp_not_detecting_newly_installed/
            -- Note this works for new modules _you_ create in golang, but not for go get.
            -- For that you need to :LspRestart and I haven't found a way around it.
            -- TODO: check what happens in 0.10
            dynamicRegistration = true,
          },
        },
      })
      -- Errors on 0.9.x
      if not vim.version.lt(vim.version, { 0, 10, 0 }) then
        opts.inlay_hints = { enabled = true }
      end

      return opts
    end,
  },
  { "neovim/nvim-lspconfig", opts = { servers = { bashls = { filetypes = { "sh", "bash" } } } } },
}
