local M = {
  "xiyaowong/nvim-transparent",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- transparency toggle
  keymap("n", "<Leader>t", ":TransparentToggle<CR>", opts)
end

return M
