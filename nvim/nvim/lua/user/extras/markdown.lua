local M = {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  lazy = false, --
}

function M.config() 

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, desc = " MarkdownToggle" }
  -- MarkdownToggle
  keymap("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>", opts )
  local ft = { "markdown" }
  vim.cmd("let g:mkdp_theme = 'dark'")
end

return M
