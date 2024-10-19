local M = {
 "Piotr1215/typeit.nvim",
  event = "VeryLazy",
}

-- This has two main options:
--   SimulateTyping file [time]
--   SimulateTypingWithPauses file [time]
--
function M.config()
  require("typeit").setup {   
    default_speed = 20,    -- Default typing speed (milliseconds)
    default_pause = 'paragraph' -- Default pause behavior ('line' or 'paragraph')
  }
end

return M
