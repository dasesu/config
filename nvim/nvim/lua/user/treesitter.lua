local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {   
    ensure_installed = {"lua", "html", "css", "javascript", "python", "cpp", "markdown", "bash" },
    -- auto_install = true, -- e.g: if i open haskell treesitter would install the respective parser
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M

