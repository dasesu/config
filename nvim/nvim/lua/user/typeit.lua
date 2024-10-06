local M = {
 "Piotr1215/typeit.nvim",
  event = "VeryLazy",
}

function M.config()
  require("typeit").setup {   
    default_speed = 30,    -- Default typing speed (milliseconds)
    default_pause = 'line' -- Default pause behavior ('line' or 'paragraph')
  }
end

return M
