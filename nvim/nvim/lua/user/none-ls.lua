local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
}

function M.config()
  local null_ls = require("null-ls")


  null_ls.setup({
    debug = false,
    sources = {

      null_ls.builtins.formatting.prettier,

      -- python
      null_ls.builtins.formatting.black,
      require("none-ls.diagnostics.flake8"),

      null_ls.builtins.completion.spell,
    },
  })
end

return M
