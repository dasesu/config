local M = {
  "EdenEast/nightfox.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  dependencies = {
    {
      "folke/tokyonight.nvim",
      lazy = true,
    },
    {
      "loctvl842/monokai-pro.nvim",
      lazy = true,
    }
  },
}

function M.config()
  -- vim.cmd.colorscheme("monokai-pro-default")
  vim.cmd.colorscheme("nightfox")
end

return M
