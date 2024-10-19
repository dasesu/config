local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local icons = require "user.icons"

  local wk = require "which-key"
  wk.add {
    -- {
    --   "<leader>g",
    --   group = " Git",
    --   icon = {
    --     icon = " ",
    --     color = "blue",
    --   },
    -- },
    {
      "<leader>gj",
      "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
      desc = "Prev Hunk"
    },
    {
      "<leader>gk",
      "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
      desc = "Next Hunk"
    },
    {
      "<leader>gp",
      "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
      desc = "Preview Hunk"
    },
    {
      "<leader>gr",
      "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
      desc = "Reset Hunk"
    },
    {
      "<leader>gl",
      "<cmd>lua require 'gitsigns'.blame_line()<cr>",
      desc = "Blame"
    },
    {
      "<leader>gR",
      "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
      desc = "Reset Buffer"
    },
    {
      "<leader>gs",
      "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
      desc = "Stage Hunk"
    },
    {
      "<leader>gu",
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      desc = "Undo Stage Hunk"
    },
    {
      "<leader>gd",
      "<cmd>Gitsigns diffthis HEAD<cr>",
      desc = "Git Diff"
    },
  }

  require("gitsigns").setup {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hu', gitsigns.undo_stage_hunk)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      map('n', '<leader>td', gitsigns.toggle_deleted)

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
end

return M
