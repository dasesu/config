require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")


-- Theme for neovim
spec("user.colorscheme")

-- A set of pre-defined fancy icons
spec("user.devicons")

-- For make the background transparent
spec("user.extras.transparent")

-- Library to create a parse tree
-- used to implement functionalities,
-- like syntax, highlighting
spec("user.treesitter")

-- for SimulateTypiping
-- eg: SimulateTyping <path> [speed]
-- eg: SimulateTypingWithPauses <path> [speed]
spec("user.extras.typeit")

-- For create hint of keymaps and shortcuts
spec("user.whichkey")

-- An easy way to interact with LSP language servers
-- for language syntax highlighting and format management
spec("user.mason-lspconfig")
-- The language server protocol
-- for a better coding experience
spec("user.lspconfig")

-- For the auto completion
spec("user.cmp")

-- null-ls is an attempt to reduce
-- the gap between non-LSP sources and LSP
-- for simplify the process of creating,
-- sharing, and setting up LSP sources using pure Lua.
spec("user.none-ls")

-- Highly versatile fuzzy finder over lists.
-- that takes searching in Neovim to another level
spec("user.telescope")

-- File explorer
spec("user.nvimtree")

-- for easy toggle code comment's
spec("user.comment")

-- Enable to set the status line
spec("user.lualine")

-- Simple winbar/statusline plugin
-- that shows your current code context
spec("user.navic")

-- Breadcrumbs is a plugin that works
-- with nvim-navic to provide context
-- about your code in the winbar
spec("user.breadcrumbs")

-- Mark files as buffer and alternate
-- between the files you want
spec("user.harpoon")

-- A vim-vinegar like file explorer that
-- lets you edit your filesystem like a
-- normal Neovim buffer.
spec("user.extras.oil")

-- For easy folding sections of text
spec("user.ufo")

-- A powerful autopair plugin that
-- supports multiple characters.
spec("user.autopairs")

-- Open a terminal
spec("user.toggleterm")

-- for Git stuffs
spec("user.gitsigns")

-- The main page when no file is called
spec("user.alpha")

-- For show the color of color
spec("user.extras.colorizer")

-- Preview markdown files
spec("user.extras.markdown")

-- live-server for html folders
spec("user.extras.liveserver")

-- Distraction-free coding for Neovim
-- spec("user.extras.zen")

-- A Neovim note taking plugin for daily
-- notes, task tracking and easy deep
-- linking across files or git commits.
-- spec("user.extras.note")


require("user.lazy")
