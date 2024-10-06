# My nvim installation, configuration and some comments

This is basically a copy of one of the Christian Chiarulli's (Chris@machine)
configuration with a few variations. The idea is keep it simple, use the
christian's structure with which i feel ocnfortable and adapt it for my use.

### Download and install nvim
Download the lastes neovim release (neovim 0.10 at the current date 26/09/24)
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mkdir -p /opt/nvim
sudo mv squashfs-root/* /opt/nvim
sudo ln -s /opt/nvim/AppRun /usr/bin/nvim
```

Copy the nvim.desktop to /usr/share/applications and edit it  
```
sudo cp nvim.desktop /usr/share/applications/
```

Or just create the file and paste this into `/usr/share/applications/nvim.desktop`  
```
[Desktop Entry]
Name=Neovim
GenericName=Text Editor
Comment=Edit text files
TryExec=nvim
Exec=nvim %F
Terminal=true
Type=Application
Keywords=Text;editor;
Icon=/opt/nvim/nvim.png
Categories=Utility;TextEditor;
StartupNotify=false
MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
X-AppImage-Version=v0.10.1
```

### Configure the environment 

Create the configuration folder, and the `init.lua` file
```
mkdir ~/.config/nvim
mkdir ~/.config/nvim/lua/user
touch ~/.config/nvim/init.lua 
```

### Launche file
Add the next content to `~/.config/nvim/lua/user/launch.lua`:
```
LAZY_PLUGIN_SPEC = {}

function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end
```

Edit the `~/.config/nvim/init.lua` file to require the launch file.
```
require("user.launch")
```

### Options
Edit the file `~/.config/nvim/lua/user/options.lua, with the next app options
```
local options = {
  --vim.opt.syntax = "enable"
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 0, -- more space in the neovim command line for displaying messages. originally 1.
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that ``` is visible in markdown files
  -- fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = false, -- ignore case in search patterns
  foldcolumn = "1", -- controla espacio de margen izquierdo
  colorcolumn = "80",
  mouse = "a", -- allow the mouse to be used in neovim
  ruler = true, -- crea el separador entre diferentes archivos abiertos con split
  pumheight = 10, -- pop up menu height
  pumblend = 10,
  showmode = false, -- show/hide the current mode, things like -- INSERT, VISUAL
  -- tabstop = 3  overwrited by softtabstop
  -- display the width of tab as 3 spaces but the tab char remain as a tab
  -- (cont) in other programas the tab is displayed as usual
  -- (cont) for example 8 "spaces".
  softtabstop = 2,
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- governs indentation via >> and friends.
  -- change tab into spaces and affect the backspace character too
  showtabline = 1, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- reacts to the syntax/style of the code you are editing (especially for C)
  smarttab = true, -- Makes tabbing smarter will realize you have 2 vs 4
  splitbelow = true, -- force all horizontal splits to go below current window
  -- autoindent = true, -- essentially tells vim to apply the indentation of the current line
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  showmatch = true, -- nos muestra donde terminan parentesis
  hidden = false, -- Requered to keep multiple buffers open
  termguicolors = true, -- set term gui colors (most terminals support this)
  undofile = true, -- enable persistent undo
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  --cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  -- relativenumber = true, -- set relative numbered lines
  laststatus = 3,
  showcmd = false,
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  updatetime = 300, -- faster completition
  timeoutlen = 700, -- this is set by default in 1000
  wrap = true, -- display lines as one long line
  scrolloff = 0,
  sidescrolloff = 8,
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  title = true,
}

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
```

And also include a call to the options file from init.lua.
```
require("user.launch")
require("user.options")
```

### Keymaps
Same procedure with the `~/.config/nvim/lua/user/keymaps.lua`.
Create the file keymaps.lua with the definition of our keymaps, and load it from init.lua.
```
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
keymap("n", "<leader>s", ":setlocal spell spelllang=es<CR>", opts)
keymap("n", "<leader>so", ":set nospell<CR>", opts)

-- word suggets with require("user.options")telescope
-- keymap("n", "z-", ":Telescope spell_suggest<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":horizontal resize -2<CR>", opts)
keymap("n", "<C-Down>", ":horizontal resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- remove keys actions
keymap("n", "<Space>", "<Nop>", opts)

-- hex mode and back
keymap("n", "<Leader>x", ":%!xxd<CR>", opts)
keymap("n", "<Leader>z", ":%!xxd -r<CR>", opts)

-- better paste ( remember original copied word )
keymap("x", "p", [["_dP]])

-- BufferlineMaps
keymap("n", "<Leader>,", ":bprevious<CR>", opts)
keymap("n", "<Leader>.", ":bnext<CR>", opts)

-- AlternateTabs
keymap("n", "<Leader>require("user.options");", "gT", opts)
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

keymap('n', '<Leader>nr', ':set rnu<CR>', opts)
keymap('n', '<Leader>nn', ':set nornu<CR>', opts)

-- Edit Snippets
keymap("n", "-", ":lua require('luasnip.loaders').edit_snippet_files()<cr>", opts)

-- NvimTree
-- keymap("n", "<Leader>e", ":NvimTreeToggle<cr>", opts)

-- Markdown
-- keymap('n', '<Leader>m', ':MarkdownPreviewToggle<CR>', opts)

-- Colorizer
keymap('n', '<Leader>c', ':ColorizerToggle<CR>', opts)

-- my functions
-- keymap("n", "<Leader>cxz", ":lua clearregister()<cr>", opts)

-- The minimap
-- keymap('n', '<Leader>mm', ':MinimapToggle<CR>', opts)
-- keymap('n', '<Leader>m', ':MinimapToggle<CR>', opts)

-- sessions
-- map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
-- keymap('n', '<F2>', ':mksession! ~/vim_session/vim_session  <cr>', opts)
-- keymap('n', '<F3>', ':source ~/vim_session/vim_session  <cr>', opts)

--vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
--vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")
```

And the respective call from the init.lua
```
require("user.launch")
require("user.options")
require("user.keymaps")
```

### The lazyvim package manager
Create the file lazy in the user directory
```
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = LAZY_PLUGIN_SPEC,
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}
```

And again, call it. 
```
require("user.launch")
require("user.options")
require("user.keymaps")
require("user.lazy")
```

### Now we can add some plugins
There is no a specific order to call the plugins, but in some cases the plugins
could depend from another plugin, in that case the order will be important.
Also keep in mind that to call a plugin we're going to use spec instead of
require  which is the array used for load plugins defined before.  
 

#### colorscheme 
Add the colorscheme plugin by creating the `~/.config/nvim/lua/user/colorscheme.lua` file.
```
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
  vim.cmd.colorscheme("nordfox")
end

return M
```

And load the file using spec
```

require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")

require("user.lazy")
```

#### Devicons
Create the file `~/.config/nvim/lua/user/devicons.lua` with the following content
```
local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  local devicons = require "nvim-web-devicons"
end

return M
```

The init.lua file:
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")

require("user.lazy")
```

#### Transparency
Create the `~/.config/nvim/lua/user/transparent.lua`
```
local M = {
  "xiyaowong/nvim-transparent",
  lazy = false, -- make sure we load this during startup
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- transparency toggle
  keymap("n", "<Leader>t", ":TransparentToggle<CR>", opts)
end

return M
```

The init.lua file:
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")

require("user.lazy")
```

#### Tree-Sitter

```
local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {   
    ensure_installed = { "html", "css", "javascript", "python", "cpp", "markdown", "bash" },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
```

The init.lua:
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")

require("user.lazy")
```

Some interesting commands:
:InspectTree -- show the parses tree 


### LSP
There are several ways to implement LSP in neovim, the first one mentioned here
is just informative, the second is using lsp-config, and the third way is using
mason

#### Native vim way (without plugin)
Vim already has a lsp server, this can be verified with the command `:lua
vim.print(vim.lsp)` for know more about how it can be use it you show the help
info with the command `:h vim.lsp.start`, this show somthing linke this: 
```
Example:
vim.lsp.start({
   name = 'my-server-name',
   cmd = {'name-of-language-server-executable'},
   root_dir = vim.fs.root(0, {'pyproject.toml', 'setup.py'}),
})
```

We are going to need a language server installed, like for example `clangd`,
This can be installed in linux with `sudo apt install clangd` or you can also
download binaries directly (https://clangd.llvm.org/installation). Now that you
have the installed clangd with the path of installation you can fill in the
fields name, cmd and root_dir.

```
-- This is a test, the important part is the next, but additional configuration
-- is needed for make it works the name field define the name asigned to out
-- language, it could be any name. the cmd contains the path to the lsp language
-- root_dir define the method used to figure out what is the project root
-- directory. generally it would be the pwd or vim.fn.getcwd()

--  vim.lsp.start({
--    name = "clangd", 
--    cmd = {"/home/dasesu/clangd/bin/clangd"},
--    root_dir = vim.fn.getcwd(),
--    
--  })
```

We need to specify what buffer to use, and when.
```
-- This is a very manually  configuration for clangd, works well but can be sturdy
-- to mantain, and has some inconvenients, for example you the languages defined
-- are always loaded, this its ok if you only use just one language.

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     vim.lsp.start({
--       name = "clangd", 
--       cmd = {"/home/dasesu/clangd/bin/clangd"},
--       root_dir = vim.fn.getcwd(),
--     })
--   end,
-- }) 
```

The both code above are demonstrative, but they works well enough for use
functionalities like `:lua vim.lsp.buf.hover()`. However there are other
options to configure LSP that can be easier

#### lspconfig 


#### Mason

Mason is a LSP manager which simplifies the LSP usage, but it has some
disadvantages, the most remarkable one is that mason create a particular
environment for nvim and it can't be used by another programs, also that mason
use some server names different than the used by LSP, this create
inconsistencies and ergo failures. Due to this the plugin lsp-mason help to
reduce the gap existent between this two tools.

Next the mason installation and its settings. 

First create the file `~/.config/nvim/lua/usr/mason.lua` and add the content:
```
local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "html",
    "cssls",
    "pyright",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }

end

return o
```
The init.lua
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.mason") -- 

require("user.lazy")
```

**Usefull stuffs:**  
Running `:lua =vim.lsp.get_active_clients()` will give you a lua table.


