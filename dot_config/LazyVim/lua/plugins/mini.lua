local function suff(suffix, opts)
  return {
    suffix = suffix,
    options = opts or {},
  }
end

local bracketed = {
  "echasnovski/mini.bracketed",
  opts = {
    buffer = suff("b"),
    -- Keep [c for classes
    comment = suff("z"),
    conflict = suff("x"),
    diagnostic = suff("d"),
    -- Keep [f for functions (treesitter config); "" disables
    file = suff(""),
    indent = suff("i"),
    jump = suff("j"),
    location = suff("l"),
    oldfile = suff("o"),
    quickfix = suff("q"),
    -- Keep [t for todos. Use n for "nodes"
    treesitter = suff("n"),
    undo = suff("u"),
    window = suff("w"),
    yank = suff("y"),
  },
}

local surround = {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      -- surround.vim-like mappings: operator first instead of default that uses gz(a/d/c)
      add = "ys",
      delete = "ds",
      replace = "cs",
    },
  },
}

return {
  bracketed,
  surround,
}
