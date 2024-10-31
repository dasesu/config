local M = {
  "junegunn/vim-easy-align",
}

function M.config()

  -- EasyAlign in visual mode
  -- allow instructions like vipga 
  vim.keymap.set("v", "ga", "<CMD>EasyAlign<CR>", { desc = "EasyAlign in Visual Mode" })

  -- EasyAlign from whichkey plugin selector
  local wk = require("which-key")
  wk.add {
    {
      "<leader>pa",
      "<cmd>EasyAlign<CR>",
      desc = " EasyAlign",
      icon = {
        icon = " ",
        color = "azure",
      },
    },
  }

end

return M
