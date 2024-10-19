-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--keymap("n", "<Esc>", "", opts)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- set spell check for spanish
keymap("n", "<leader>s", ":setlocal spell spelllang=es<CR>", opts )
keymap("n", "<leader>so", ":set nospell<CR>", opts)

-- word suggets with telescope
-- keymap("n", "z-", ":Telescope spell_suggest<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":horizontal resize -2<CR>", opts)
keymap("n", "<C-Down>", ":horizontal resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- remove keys actions
keymap("n", "<Space>", "<Nop>", opts)

-- hex mode and back
-- keymap("n", "<Leader>x", ":%!xxd<CR>", opts)
-- keymap("n", "<Leader>z", ":%!xxd -r<CR>", opts)

-- better paste ( remember original copied word )
keymap("x", "p", [["_dP]])

-- BufferlineMaps
keymap("n", "<Leader>,", ":bprevious<CR>", opts)
keymap("n", "<Leader>.", ":bnext<CR>", opts)

-- AlternateTabs
keymap("n", "<Leader>;", "gT", opts)
keymap("n", "<Leader>'", "gt", opts)

-- classic save shortcut
keymap("n", "<C-s>", ":w<CR>", opts)

-- classic copy, cut, and paste shortcuts
keymap("v", "<C-c>", '"+yi', opts)
keymap("v", "<C-x>", '"+c', opts)
keymap("v", "<C-v>", 'c<ESC>"+p', opts)
keymap("i", "<C-v>", "<C-r><C-o>+", opts)

-- Indent
keymap("n", "<TAB>", ">>_", opts)
keymap("n", "<S-TAB>", "<<_", opts)
keymap("i", "<S-TAB>", "<C-D>", opts)
keymap("v", "<TAB>", ">gv", opts)
keymap("v", "<S-TAB>", "<gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- for forcing the ts=2 and sw=2
keymap("n", "sw", ":set ts=2<CR>:set sw=2<CR>", opts)

-- no hilight search
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)

-- keymap('n', '<Leader>nr', ':set rnu<CR>', opts)
-- keymap('n', '<Leader>nn', ':set nornu<CR>', opts)

-- Edit Snippets
keymap("n", "-", ":lua require('luasnip.loaders').edit_snippet_files()<cr>", opts)

-- Colorizer
keymap('n', '<Leader>c', ':ColorizerToggle<CR>', opts)

-- Markdown
-- keymap('n', '<Leader>m', ':ggle<CR>', opts)


-- sessions
-- map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
-- keymap('n', '<F2>', ':mksession! ~/vim_session/vim_session  <cr>', opts)
-- keymap('n', '<F3>', ':source ~/vim_session/vim_session  <cr>', opts)

