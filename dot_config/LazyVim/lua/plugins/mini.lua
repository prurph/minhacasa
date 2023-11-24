-- ~ Configuration for echasnovski/mini.nvim plugins

local surround = {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "ys",
      delete = "ds",
      replace = "cs",
    },
  },
}

return {
  surround,
}
