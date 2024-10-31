local M = {
  "norcalli/nvim-colorizer.lua",
}

function M.config()
  -- local keymap = vim.keymap.set
  -- local opts = { noremap = true, silent = true }
  -- keymap("n", "<Leader>c", ":ColorizerToggle<CR>", opts)
  local wk = require("which-key")
  wk.add {
    {
      "<leader>pc",
      "<cmd>ColorizerToggle<CR>",
      desc = " ColorizerToggle",
      icon = {
        icon = " ",
        color = "azure",
      },
    },
  }

  require("colorizer").setup({
    '*', -- Highlight all files
    -- 'css',
    -- 'javascript',
    -- html = {
    --   mode = 'foreground',
    -- }
  })
end

return M
