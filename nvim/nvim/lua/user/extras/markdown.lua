local M = {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  lazy = false, --
}

function M.config()

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- MarkdownToggle
  keymap("n", "<Leader>m", ":MarkdownPreviewToggle<CR>", opts)
  local ft = { "markdown" }
  vim.cmd("let g:mkdp_theme = 'dark'")
end

return M
