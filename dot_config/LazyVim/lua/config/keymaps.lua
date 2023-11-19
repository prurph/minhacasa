-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local nvim_tmux_navigation = require("nvim-tmux-navigation")
local wk = require("which-key")

local Popup = require("nui.popup")
local Line = require("nui.line")

wk.register({
  ["<leader>o"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd("p")
      else
        vim.cmd.Neotree("focus")
      end
    end,
    "Toggle Explorer Focus [P]",
  },

  -- ~ Tmux Navigator
  ["<C-h>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateLeft,
    "Move to split left [P]",
  },
  ["<C-j>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateDown,
    "Move to split below [P]",
  },
  ["<C-k>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateUp,
    "Move to split below [P]",
  },
  ["<C-l>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateRight,
    "Move to split right [P]",
  },
  ["<C-\\>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateLastActive,
    "Move to last active split [P]",
  },
  ["<C-Space>"] = {
    nvim_tmux_navigation.NvimTmuxNavigateNext,
    "Move to next split [P]",
  },

  -- ~ Bespoke custom stuff
  ["<leader>si"] = {
    function()
      -- Lua doesn't iterate tables in any order, so make table of tuples and use ipairs
      local icons = {
        { "Change Type", "", "NotifyInfoTitle" },
        { "Added", "✚ " },
        { "Deleted", "✖ " },
        { "Modified", " " },
        { "Renamed", "󰁕 " },
        { "", "", "NONE" },
        { "Status Type", "", "NotifyInfoTitle" },
        { "Untracked", " " },
        { "Ignored", " " },
        { "Unstaged", "󰄱 " },
        { "Staged", " " },
        { "Conflict", " " },
      }

      local scratch_buffer, line_nr = vim.api.nvim_create_buf(false, true), 1
      for i, _ in ipairs(icons) do
        local line = Line()
        table.unpack = table.unpack or unpack -- Lua 5.1 compatibility
        local key, icon, hl = table.unpack(icons[i])
        hl = hl or ("NeoTreeGit" .. key)
        line:append(icon .. key, hl)
        line:render(scratch_buffer, -1, line_nr)
        line_nr = line_nr + 1
      end

      local popup_options = {
        border = {
          style = "rounded",
          text = {
            top = " Neo-tree Icon Legend ",
            top_align = "left",
          },
          padding = {
            top = 1,
            left = 2,
            bottom = 1,
          },
        },
        enter = "true",
        anchor = "NW",
        win_options = {
          winblend = 30,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        position = {
          row = 3,
          col = "98%",
        },
        size = {
          width = 30,
          height = #icons,
        },
        bufnr = scratch_buffer,
      }

      local popup = Popup(popup_options)

      -- unmount() alone doesn't seem to delete the buffer
      local function unmount_del_buf()
        vim.api.nvim_buf_delete(scratch_buffer, {})
        popup:unmount()
      end

      popup:mount()

      popup:map("n", { "<esc>", "c", "q", "x", "d" }, function()
        unmount_del_buf()
      end, { noremap = true })

      popup:on("BufLeave", function()
        vim.api.nvim_buf_delete(scratch_buffer, {})
        popup:unmount()
      end, { once = true })

      -- Below using notify doesn't quite work.
      -- Replacing the buffer removes the title of the notification.
      -- Tried using buf_get_lines to get the header first and stick it in,
      -- but that doesn't work (it's virtual text), and trying to get lines from
      -- the nui.nvim buffer only gets the text, no highlighting.
      -- https://github.com/rcarriga/nvim-notify/issues/230
      -- local ls = vim.api.nvim_buf_get_lines(scratch_buffer, 0, -1, false)
      -- notify.notify(ls, "info", {
      --   title = "Neo-tree Icon Legend",
      --   timeout = 2000,
      --   on_open = function(win)
      --     vim.api.nvim_win_set_buf(win, scratch_buffer)
      --   end,
      -- })
    end,
    "Show Neo-tree legend [P]",
  },
})
