local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local which_key = require("which-key")

  which_key.setup {
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = 550,
    ---@param mapping wk.Mapping
    filter = function(mapping)
      -- example to exclude mappings without a description
      -- return true
      return mapping.desc and mapping.desc ~= ""
    end,

    --- You can add any mappings here, or use `require('which-key').add()` later
    ---@type wk.Spec
    spec = {},

    plugins = {
      marks = false,     -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list
      },
      presets = {
        operators = false,    -- adds help for operators like d, y, ...
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
      },
    },
    win = {
      border = "rounded",
      no_overlap = false, -- don't allow the popup to overlap with the cursor
      padding = { 1, 0 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "left",
      zindex = 1000,
    },
    -- layout = {
    --   width = { min = 20 }, -- min and max width of the columns
    --   spacing = 3, -- spacing between columns
    -- },
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,

    keys = {
      scroll_down = "<Down>", -- binding to scroll down inside the popup
      scroll_up = "<Up>",     -- binding to scroll up inside the popup
    },
    ---@type (string|wk.Sorter)[]
    --- Mappings are sorted using configured sorters and natural sort of the keys
    --- Available sorters:
    --- * local: buffer-local mappings first
    --- * order: order of the items (Used by plugins like marks / registers)
    --- * group: groups last
    --- * alphanum: alpha-numerical first
    --- * mod: special modifier keys last
    --- * manual: the order the mappings were added
    --- * case: lower-case first
    sort = { "manual", "order", "group", "alphanum", "mod", "local" },

    icons = {
      rules = {
        { plugin = "fzf-lua", cat = "filetype", name = "fzf" },
        { plugin = "neo-tree.nvim", cat = "filetype", name = "neo-tree" },
        { plugin = "octo.nvim", cat = "filetype", name = "git" },
        { plugin = "yanky.nvim", icon = "󰅇", color = "yellow" },
        { plugin = "zen-mode.nvim", icon = "󱅻 ", color = "cyan" },
        { plugin = "telescope.nvim", pattern = "telescope", icon = "", color = "blue" },
        { plugin = "trouble.nvim", cat = "filetype", name = "trouble" },
        { plugin = "todo-comments.nvim", cat = "file", name = "TODO" },
        { plugin = "grapple.nvim", pattern = "grapple", icon = "󰛢", color = "azure" },
        { plugin = "nvim-spectre", icon = "󰛔 ", color = "blue" },
        { plugin = "grug-far.nvim", pattern = "grug", icon = "󰛔 ", color = "blue" },
        { plugin = "noice.nvim", pattern = "noice", icon = "󰈸", color = "orange" },
        { plugin = "persistence.nvim", icon = " ", color = "azure" },
        { plugin = "neotest", cat = "filetype", name = "neotest-summary" },
        { plugin = "lazy.nvim", cat = "filetype", name = "lazy" },
        { plugin = "CopilotChat.nvim", icon = " ", color = "orange" },
        { pattern = "%f[%a]git", cat = "filetype", name = "git" },
        { pattern = "terminal", icon = " ", color = "blue" },
        { pattern = "find", icon = " ", color = "green" },
        { pattern = "search", icon = " ", color = "blue" },
        { pattern = "test", cat = "filetype", name = "neotest-summary" },
        { pattern = "lazy", cat = "filetype", name = "lazy" },
        { pattern = "buffer", icon = "󰈔", color = "blue" },
        { pattern = "file", icon = "󰈔", color = "blue" },
        { pattern = "window", icon = " ", color = "blue" },
        { pattern = "diagnostic", icon = "󱖫 ", color = "green" },
        { pattern = "format", icon = " ", color = "blue" },
        { pattern = "debug", icon = "󰃤 ", color = "red" },
        { pattern = "code", icon = " ", color = "orange" },
        { pattern = "notif", icon = "󰵅 ", color = "blue" },
        { pattern = "toggle", icon = " ", color = "blue" },
        { pattern = "session", icon = " ", color = "azure" },
        { pattern = "exit", icon = "󰈆 ", color = "red" },
        { pattern = "quit", icon = "󰈆 ", color = "red" },
        { pattern = "tab", icon = "󰓩 ", color = "purple" },
        { pattern = "%f[%a]ai", icon = " ", color = "green" },
        { pattern = "ui", icon = "󰙵 ", color = "cyan" },
      },

    },

    -- disable WhichKey for certain buf types and file types.
    disable = {
      buftypes = {},
      filetypes = {},
    },
  }

  local wk = require("which-key")


  -- icon colors
  -- azure, grey, cyan, green, grey, orange, purple, red, yellow
  wk.add {
    {
      "<leader>f",
      group = " Telescope",
      icon = {
        icon = "",
        color = "grey",
      },
    },
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = " NvimTree",
      icon = {
        icon = "",
        color = "grey",
      },
    },
    {
      "<leader>l",
      group = " LSP",
      icon = {
        icon = " ",
        color = "grey",
      },
    },
    {
      "<leader>g",
      group = " Git",
      icon = {
        icon = " ",
        color = "grey",
      },
    },
    {
      "<leader>m",
      group = " Markdown",
      icon = {
        icon = " ",
        color = "grey",
      },
    },
    {
      "<leader>c",
      "<cmd>ColorizerToggle<CR>",
      desc = " ColorizerToggle",
      icon = {
        icon = " ",
        color = "grey",
      },
    },
    {
      "<leader>w",
      "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>",
      desc = "Wrap",
      hidden = true,
    },

    {
      "<leader>p",
      group = "Plugins",
      icon = {
        icon = " ",
        color = "cyan",
      },
    },
  }
end

return M
