local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")
local trouble_telescope = require("trouble.providers.telescope")
local trouble = require("trouble")

local function lga_grep(opts)
  require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

-- From https://github.com/nvim-telescope/telescope-live-grep-args.nvim/blob/851c0997d55601f2afd7290db0f90dc364e29f58/lua/telescope-live-grep-args/shortcuts.lua
local function get_visual_selection()
  local unpack = unpack or table.unpack
  local _, ls, cs = unpack(vim.fn.getpos("v"))
  local _, le, ce = unpack(vim.fn.getpos("."))
  local visual = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
  return visual[1] or ""
end

local function send_to_qflist(bufnr)
  actions.smart_send_to_qflist(bufnr)
  trouble.open("quickfix")
end

local function send_to_loclist(bufnr)
  actions.smart_send_to_loclist(bufnr)
  trouble.open("loclist")
end

-- Convenience functions to work with live-grep args
-- The norm! commands are to position the cursor.
local function quote_prompt(bufnr)
  require("telescope-live-grep-args.actions").quote_prompt()(bufnr)
end
local function quote_prompt_ignoredir(bufnr)
  require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob '!**//**'" })(bufnr)
  vim.cmd("norm! 4h")
end
local function quote_prompt_globdir(bufnr)
  require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob '**//**'" })(bufnr)
  vim.cmd("norm! 4h")
end
local function quote_prompt_type(bufnr)
  require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t " })(bufnr)
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
  keys = {
    -- LazyVim default uses sort_mru which often selects worse matches and is infuriating 😅
    { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix [P]" },
    { "<leader>sQ", "<cmd>Telescope quickfixhistory<cr>", desc = "Quickfix history [P]" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Search loclist [P]" },

    { "<leader>sp", "<cmd>Telescope noice<cr>", desc = "Noice [P]" },
    { "<leader>sP", "<cmd>Telescope notify<cr>", desc = "Notify [P]" },

    { "<leader>/", lga_grep, desc = "Grep (root dir)" },
    { "<leader>sg", lga_grep, desc = "Grep (root dir)" },
    {
      "<leader>sG",
      function()
        lga_grep({ search_dirs = { require("telescope.utils").buffer_dir() } })
      end,
      desc = "Grep (cwd)",
    },
    -- Unfortunately the utility functions don't allow other args
    -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim/blob/851c0997d55601f2afd7290db0f90dc364e29f58/lua/telescope-live-grep-args/shortcuts.lua#L44
    {
      "<leader>sw",
      function()
        local word = vim.fn.expand("<cword>")
        lga_grep({ default_text = word })
      end,
      desc = "Word (root dir)",
    },
    {
      "<leader>sw",
      function()
        local selection = get_visual_selection()
        lga_grep({ default_text = selection })
      end,
      mode = "v",
      desc = "Selection (root dir)",
    },
    {
      "<leader>sW",
      function()
        local word = vim.fn.expand("<cword>")
        lga_grep({ default_text = word, search_dirs = { require("telescope.utils").buffer_dir() } })
      end,
      desc = "Word (cwd)",
    },
    {
      "<leader>sW",
      function()
        local selection = get_visual_selection()
        lga_grep({ default_text = selection, search_dirs = { require("telescope.utils").buffer_dir() } })
      end,
      mode = "v",
      desc = "Word (cwd)",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-n>"] = actions.cycle_history_next,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-h>"] = actions.preview_scrolling_left,
          ["<C-l>"] = actions.preview_scrolling_right,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.preview_scrolling_up,

          ["<M-t>"] = trouble_telescope.smart_open_with_trouble,
          ["<M-q>"] = send_to_qflist,
          ["<M-c>"] = send_to_loclist,

          ["<M-v>"] = layout.toggle_preview,
        },
        n = {
          ["<C-h>"] = actions.preview_scrolling_left,
          ["<C-l>"] = actions.preview_scrolling_right,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.preview_scrolling_up,

          ["<C-x>"] = actions.select_horizontal,

          ["<M-t>"] = trouble_telescope.smart_open_with_trouble,
          ["<M-q>"] = send_to_qflist,
          ["<M-c>"] = send_to_loclist,

          ["<M-v>"] = layout.toggle_preview,
        },
      },
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-e>"] = quote_prompt,
            ["<C-y>"] = quote_prompt_globdir,
            ["<C-i>"] = quote_prompt_ignoredir,
            ["<C-s>"] = quote_prompt_type,
          },
        },
      },
    },
  },
}
