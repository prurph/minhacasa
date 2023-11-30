-- Adapters: https://github.com/nvim-neotest/neotest#supported-runners
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-plenary" },
      { "nvim-neotest/neotest-go" },
    },
    opts = {
      -- List of adapters, or list of names, or table of names mapped to configs
      -- https://www.lazyvim.org/extras/test/core#neotest-1
      adapters = {
        "neotest-plenary",
        "neotest-go",
      },
    },
  },
}
