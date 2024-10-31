local M = {
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below


    window = {
      backdrop = 0.35, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- * a function that returns the width or the height
      width = 120, -- width of the Zen window
      height = 1,  -- height of the Zen window
      -- by default, no options are changed for the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        -- number = false, -- disable number column
        -- relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
        -- you may turn on/off statusline in zen mode by setting 'laststatus'
        -- statusline will be shown only if 'laststatus' == 3
        laststatus = 0,             -- turn off the statusline in zen mode
      },
      gitsigns = { enabled = true }, -- disables git signs
      tmux = { enabled = false },   -- disables the tmux statusline
      -- todo = { enabled = false },   -- if set to "true", todo-comments.nvim highlights will be disabled
      -- this will change the font size on alacritty when in zen mode
      -- requires  Alacritty Version 0.10.0 or higher
      -- uses `alacritty msg` subcommand to change font size
      -- alacritty = {
      --   enabled = false,
      --   font = "14", -- font size
      -- },
    },

  }
}

function M.config()

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, desc = " ZenMode" }
  -- MarkdownToggle
  -- keymap("n", "<Leader>pz", ":ZenMode<CR>", opts )
  local wk = require("which-key")
  wk.add {
    {
      "<leader>pz",
      "<cmd>ZenMode<CR>",
      desc = " ZenToggle",
      icon = {
        icon = " ",
        color = "azure",
      },
    },
  }


end


return M
