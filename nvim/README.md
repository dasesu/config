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

**Some interesting commands:**  
:InspectTree -- show the parses tree 
:Inspect -- show information of the parser under the cursor


### LSP
There are several ways to implement LSP in neovim, the first one mentioned here
is just informative 

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

### More keymaps through the Which-key

The file `~/.config/nvim/lua/user/whichkey.lua` contains the configuration of
whichkey and some keymaps, this file is going to change meanwhile more plugins
and files will be added. Reason why we came back to this file later.
```
local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local which_key = require "which-key"
  which_key.setup {
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = 450,
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
      marks = true,      -- shows a list of your marks on ' and `
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
    sort = { "local", "order", "group", "alphanum", "mod", "manual" },
    -- disable WhichKey for certain buf types and file types.
    disable = {
      buftypes = {},
      filetypes = {},
    },
  }

  local wk = require "which-key"

  -- icon colors
  -- azure, blue, cyan, green, grey, orange, purple, red, yellow

  wk.add {
    {
      "<leader>r",
      "<cmd>tabnew | terminal<CR>",
      desc = "Term",
      icon = {
        icon = " ",
        color = "green",
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
        color = "azure",
      },
    },
  }
end

return M
```

In the init.lua file:
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 

require("user.lazy")
```

#### Mason
Mason is a LSP manager which simplifies the LSP usage, but it has some
disadvantages, the most remarkable one is that mason create a particular
environment for nvim and it can't be used by another programs, also that mason
use some server names different than the used by LSP, this create
inconsistencies and ergo failures. Due to this the plugin mason-lspconfig help to
reduce the gap existent between this two tools.

Next the mason-lspconfig installation and its settings. You can see that
mason-lspconfig depends of mason, the configurations will be in the
mason-lspconfig.lua which include the installation of mason through the dependencies definition.

First create the file `~/.config/nvim/lua/usr/mason-lspconfig.lua` and add the content:
```
local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "lua_ls",
    "html",
    "cssls",
    "bashls",
    "clangd",
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
spec("user.whichkey")
spec("user.mason-lspconfig") 

require("user.lazy")
```

**Usefull stuffs:**  
`:lua =vim.lsp.get_active_clients()` show a lua table of active clients.

### LSP

Now to config `lspconfig`, create the file `~/.config/nvim/lua/user/lspconfig.lua`
with:
```
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts) -- also <leader> lf
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  --if client.supports_method "textDocument/inlayHint" then
  --  vim.lsp.inlay_hint.enable(bufnr, true)
  --end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local wk = require("which-key")
  wk.add {
    {
      "<leader>l",
      group = " LSP",
      icon = {
        icon = " ",
        color = "azure",
      },
    },
    {
      "<leader>li",
      "<cmd>LspInfo<cr>",
      desc = " Info"
    },
    {
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>", 
      desc = " Rename"
    },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = " Format"
    },
    {
      "lj",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = " Prev Diagnostic"
    },
    { 
      "lk",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      desc = " Next Diagnostic" 
    },
  }

  local lspconfig = require "lspconfig"
  local icons = require "user.icons"

  local servers = {
    "lua_ls",
    "html",
    "cssls",
    "bashls",
    "clangd",
    "pyright",
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }
    lspconfig[server].setup(opts)
  end
end

return M
```

And from `init.lua`
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")

require("user.lazy")
```

The defined icons for graphic info like warning, erros, etc, are in `~/.config/nvim/lua/user/icons.lua`  
```
return {
  kind = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = "󰉋 ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    -- Module = " ",
    Module = " ",
    Namespace = " ",
    Null = "󰟢 ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
  git = {
    LineAdded = " ",
    LineModified = " ",
    LineRemoved = " ",
    FileDeleted = " ",
    FileIgnored = "◌",
    FileRenamed = " ",
    FileStaged = "S",
    FileUnmerged = "",
    FileUnstaged = "",
    FileUntracked = "U",
    Diff = " ",
    Repo = " ",
    Octoface = " ",
    Copilot = " ",
    Branch = "",
  },
  ui = {
    ArrowCircleDown = "",
    ArrowCircleLeft = "",
    ArrowCircleRight = "",
    ArrowCircleUp = "",
    BoldArrowDown = "",
    BoldArrowLeft = "",
    BoldArrowRight = "",
    BoldArrowUp = "",
    BoldClose = "",
    BoldDividerLeft = "",
    BoldDividerRight = "",
    BoldLineLeft = "▎",
    BoldLineMiddle = "┃",
    BoldLineDashedMiddle = "┋",
    BookMark = "",
    BoxChecked = " ",
    Bug = " ",
    Stacks = "",
    Scopes = "",
    Watches = "󰂥",
    DebugConsole = " ",
    Calendar = " ",
    Check = "",
    ChevronRight = "",
    ChevronShortDown = "",
    ChevronShortLeft = "",
    ChevronShortRight = "",
    ChevronShortUp = "",
    Circle = " ",
    Close = "󰅖",
    CloudDownload = " ",
    Code = "",
    Comment = "",
    Dashboard = "",
    DividerLeft = "",
    DividerRight = "",
    DoubleChevronRight = "»",
    Ellipsis = "",
    EmptyFolder = " ",
    EmptyFolderOpen = " ",
    File = " ",
    FileSymlink = "",
    Files = " ",
    FindFile = "󰈞",
    FindText = "󰊄",
    Fire = "",
    Folder = "󰉋 ",
    FolderOpen = " ",
    FolderSymlink = " ",
    Forward = " ",
    Gear = " ",
    History = " ",
    Lightbulb = " ",
    LineLeft = "▏",
    LineMiddle = "│",
    List = " ",
    Lock = " ",
    NewFile = " ",
    Note = " ",
    Package = " ",
    Pencil = "󰏫 ",
    Plus = " ",
    Project = " ",
    Search = " ",
    SignIn = " ",
    SignOut = " ",
    Tab = "󰌒 ",
    Table = " ",
    Target = "󰀘 ",
    Telescope = " ",
    Text = " ",
    Tree = "",
    Triangle = "󰐊",
    TriangleShortArrowDown = "",
    TriangleShortArrowLeft = "",
    TriangleShortArrowRight = "",
    TriangleShortArrowUp = "",
  },
  diagnostics = {
    BoldError = "",
    Error = "",
    BoldWarning = "",
    Warning = "",
    BoldInformation = "",
    Information = "",
    BoldQuestion = "",
    Question = "",
    BoldHint = "",
    Hint = "󰌶",
    Debug = "",
    Trace = "✎",
  },
  misc = {
    Robot = "󰚩 ",
    Squirrel = " ",
    Tag = " ",
    Watch = "",
    Smiley = " ",
    Package = " ",
    CircuitBoard = " ",
  },
}
```

As this file not execute any function, neither it has config or plugin
associated to it, there is no need to load it from init.lua.


### Text compleition
Add the following content to the `~/.config/nvim/lua/user/cmp.lua` file:  
```
local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path",
      event = "InsertEnter",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/cmp-calc"
    },
  },
}


function M.config()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/user/snippets/friendly-snippets/" } })
  require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/user/snippets/snippets/" } })

  vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })

    local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local icons = require "user.icons"

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<Up>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Down>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Left>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<Right>"] =  cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },

    formating = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
        })[entry.source.name]

        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      -- { name = "cmp_tabnine" },
      -- { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
    experimental = {
      ghost_text = false,
    },
  }
end

return M
```

And the definition from `init.lua`
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")

require("user.lazy")
```


### LSP without LSP, null-ls or none-ls
This is an attempt to reduce the gap between non-LSP sources and LSP for
simplify the process of creating, sharing, and setting up LSP sources using
pure Lua.

For the next code we assume that following is already installed through mason:
`formatting: [prettier,black`, `linter: [flake8]`

Create the file `~/.config/nvim/lua/user/none-ls.lua` with:  
```
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
      null_ls.builtins.formatting.black,
      require("none-ls.diagnostics.flake8"), -- none-ls-extras.nvim is required
      null_ls.builtins.completion.spell,
    },
  })
end

return M
```

And add the call from the init.lua file.
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")

require("user.lazy")
```

### Telescope
Add the following to `~/.config/nvim/lua/user/telescope.lua`
```
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      lazy = true,
    },
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
  },
}

function M.config()

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- word suggets with telescope
  keymap("n", "z-", ":Telescope spell_suggest<CR>", opts)

  local wk = require("which-key")
  wk.add {
    {
      "<leader>f",
      group = " Telescope",
      icon = {
        icon = "",
        color = "azure",
      },
    },
    { "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", desc = " Buffers" },
    { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    -- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fj", "<cmd>Telescope jumplist previewer=false<cr>", desc = "Jumps" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
    { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
  }

  local icons = require("user.icons")
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<down>"] = actions.move_selection_next,
          ["<up>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  })
end

return M
```

And add the call to Telescope from `init.lua`  
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")
spec("user.telescope")

require("user.lazy")
```

We install ripgrep for the text find option  
```
sudo apt install ripgrep
```


### Nvimtree navigation
This is a nice file explorer.

Create a file `~/.config/nvim/lua/user/nvimtree.lua` and add this:  
```
local M = {
  "nvim-tree/nvim-tree.lua",
}

function M.config()
  local wk = require("which-key")
  wk.add {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
  }

  local icons = require("user.icons")

  require("nvim-tree").setup({
    hijack_netrw = false,
    sync_root_with_cwd = false,
    view = {
      relativenumber = false,
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      full_name = false,
      highlight_opened_files = "none",
      root_folder_label = ":t",
      indent_width = 1,
      indent_markers = {
        enable = false,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          none = " ",
        },
      },
      icons = {
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        glyphs = {
          default = icons.ui.Text,
          symlink = icons.ui.FileSymlink,
          bookmark = icons.ui.BookMark,
          folder = {
            arrow_closed = icons.ui.ChevronRight,
            arrow_open = icons.ui.ChevronShortDown,
            default = icons.ui.Folder,
            open = icons.ui.FolderOpen,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            symlink = icons.ui.FolderSymlink,
            symlink_open = icons.ui.FolderOpen,
          },
          git = {
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            unmerged = icons.git.FileUnmerged,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            deleted = icons.git.FileDeleted,
            ignored = icons.git.FileIgnored,
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      symlink_destination = true,
    },
    update_focused_file = {
      enable = true,
      debounce_delay = 15,
      update_root = false,
      ignore_list = {},
    },

    diagnostics = {
      enable = true,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.BoldHint,
        info = icons.diagnostics.BoldInformation,
        warning = icons.diagnostics.BoldWarning,
        error = icons.diagnostics.BoldError,
      },
    },
  })
end

return M
```

Add the call from init.lua.
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")
spec("user.telescope")
spec("user.nvimtree")

require("user.lazy")
```

### Comments
```
local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" },
  }

  vim.g.skip_ts_context_commentstring_module = true
  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  }
end

return M
```

init.lua  
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")
spec("user.telescope")
spec("user.nvimtree")
spec("user.comment")

require("user.lazy")
```

### Lualine
A blazing fast and easy to configure Neovim statusline written in Lua.

```
local M = {
  "nvim-lualine/lualine.nvim",
  -- dependencies = {
--   "AndreM222/copilot-lualine",
  -- },
}

function M.config()
  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = {},
      lualine_b = { "branch" },
      lualine_c = { "diagnostics" },
      lualine_x = { "", "filetype" },
      lualine_y = { "location" },
      lualine_z = {"progress"},
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
```

init.lua  
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")
spec("user.telescope")
spec("user.nvimtree")
spec("user.comment")
spec("user.lualine")

require("user.lazy")
```

###  NAvic and breadcrumbs

The `~/.config/nvim/lua/user/navic.lua` file
```
local M = {
  "SmiteshP/nvim-navic",
}

function M.config()
  local icons = require "user.icons"
  require("nvim-navic").setup {
    icons = icons.kind,
    highlight = true,
    lsp = {
      auto_attach = true,
    },
    click = true,
    separator = " " .. icons.ui.ChevronRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
  }
end

return M
```

The `~/.config/nvim/lua/user/breadcrumbs.lua` file
```
local M = {
  "LunarVim/breadcrumbs.nvim",
}

function M.config()
  require("breadcrumbs").setup()
end

return M
```

and the `init./lua`
```
require("user.launch")
require("user.options")
require("user.keymaps")

spec("user.colorscheme")
spec("user.devicons")
spec("user.transparent")
spec("user.treesitter")
spec("user.whichkey")
spec("user.mason-lspconfig") 
spec("user.lspconfig")
spec("user.cmp")
spec("user.none-ls")
spec("user.telescope")
spec("user.nvimtree")
spec("user.comment")
spec("user.lualine")
spec("user.navic")
spec("user.breadcrumbs")

require("user.lazy")
```

### Harpoon 
Mark files as buffer and alternate between the files you want

Edit the file `~/.config/nvim/lua/user/harpoon.lua` with:  

```
local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  keymap("n", "<Leader><TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
  keymap("n", "<s-m>", "<cmd>lua require('user.harpoon').mark_file()<cr>", opts)
end


function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "  marked file"
end

return M
```

init.lua 
```
...

spec("user.harpoon")
...
```

### Oil 
A vim-vinegar like file explorer that lets you edit your filesystem like a
normal Neovim buffer.
```
local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup {
    float = {
      max_height = 20,
      max_width = 75,
    },
  }
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Oil File explorer" })
end

return M
```
init.lua 
```
...

spec("user.oil")
...
```

### Ufo folding
for a comfortable folding
```
local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "luukvbaal/statuscol.nvim",
  },
}

function M.config()
  local builtin = require "statuscol.builtin"
  local cfg = {
    setopt = true,
    relculright = true,
    segments = {

      { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },

      { text = { "%s" }, click = "v:lua.ScSa" },
      { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
    },
  }

  require("statuscol").setup(cfg)

  vim.o.foldcolumn = "1" -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰡏 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end

  local ftMap = {
    -- typescriptreact = { "lsp", "treesitter" },
    -- python = { "indent" },
    -- git = "",
  }

  require("ufo").setup {
    fold_virt_text_handler = handler,
    close_fold_kinds = {},
    -- close_fold_kinds = { "imports", "comment" },
    provider_selector = function(bufnr, filetype, buftype)
      -- if you prefer treesitter provider rather than lsp,
      -- return ftMap[filetype] or {'treesitter', 'indent'}
      return ftMap[filetype]
      -- return { "treesitter", "indent" }

      -- refer to ./doc/example.lua for detail
    end,

    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
      mappings = {
        scrollU = "<C-k>",
        scrollD = "<C-j>",
        jumpTop = "[",
        jumpBot = "]",
      },
    },
  }

  vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
  vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  vim.keymap.set("n", "K", function()

    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end)
end

return M
```

init.lua:  
```
...
spec("user.ufo")
...
```

### Autocmds 
This file add some functionalities that make the usage more fluid

Edit the file `~/.config/nvim/lua/user/autocmds.lua` with:  
```
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})



vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    -- "netrw",
    -- "Jaq",
    -- "qf",
    -- "spectre_panel",
    -- "lir",
    -- "DressingSelect",
    -- "tsplayground",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",

    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

-- I like it
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd [[silent! lua require("luasnip").unlink_current()]]
    end
  end,
})
```

and it must be required from init.lua but observe that this is not an table,
this file is just a bunch of functions so in the top of the `init.lua` file add
the `require("user.autocmds")` 

```
require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds") -- like this

-- Theme for neovim
spec("user.colorscheme")

-- A set of pre-defined fancy icons
spec("user.devicons")
...
```

### Autopairs

File `~/.config/nvim/lua/user/autopairs.lua`
```
local M = {
  "windwp/nvim-autopairs",
}

M.config = function()
  require("nvim-autopairs").setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "spectre_panel", "oil" },
  }
end

return M
```

and the `init.lua`  
```
...
spec("user.autopairs")
...
```

### Toggleterm

Edit the file `~/.config/nvim/lua/user/toggleterm.lua`:  
```
local M = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
}

function M.config()
  local execs = {
    { nil, "<M-1>", "Float Terminal", "float", nil },
    { nil, "<M-2>", "Horizontal Terminal", "horizontal", 0.3 },
  }

  local function get_buf_size()
    local cbuf = vim.api.nvim_get_current_buf()
    local bufinfo = vim.tbl_filter(function(buf)
      return buf.bufnr == cbuf
    end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
    if bufinfo == nil then
      return { width = -1, height = -1 }
    end
    return { width = bufinfo.width, height = bufinfo.height }
  end

  local function get_dynamic_terminal_size(direction, size)
    size = size
    if direction ~= "float" and tostring(size):find(".", 1, true) then
      size = math.min(size, 1.0)
      local buf_sizes = get_buf_size()
      local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
      return buf_size * size
    else
      return size
    end
  end

  local exec_toggle = function(opts)
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
    term:toggle(opts.size, opts.direction)
  end

  local add_exec = function(opts)
    local binary = opts.cmd:match("(%S+)")
    if vim.fn.executable(binary) ~= 1 then
      vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
      return
    end

    vim.keymap.set({ "n", "t" }, opts.keymap, function()
      exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() })
    end, { desc = opts.label, noremap = true, silent = true })
  end

  for i, exec in pairs(execs) do
    local direction = exec[4]

    local opts = {
      cmd = exec[1] or vim.o.shell,
      keymap = exec[2],
      label = exec[3],
      count = i + 100,
      direction = direction,
      size = function()
        return get_dynamic_terminal_size(direction, exec[5])
      end,
    }

    add_exec(opts)
  end

  require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    float_opts = {
      border = "rounded",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = true,
      name_formatter = function(term) --  term: Terminal
        return term.count
      end,
    },
  })
  vim.cmd([[
  augroup terminal_setup | au!
  autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
  autocmd TermEnter * startinsert!
  augroup end
  ]])

  vim.api.nvim_create_autocmd({ "TermEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.cmd("startinsert")
      _G.set_terminal_keymaps()
    end,
  })

  local opts = { noremap = true, silent = true }
  function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
  end
end

return M
```

and the `init.lua`
```
...
spec("user.toggleterm")
```


### Fidget
For notification an progress messages

Edit de file `~/.config/nvim/lua/user/fidget.lua`
```
local M = {
  "j-hui/fidget.nvim",
}

function M.config()
  require("fidget").setup {
    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },

    notification = {
      window = {
        normal_hl = "CursorLineNr", -- Base highlight group in the notification window
        winblend = 100, -- Background color opacity in the notification window
        border = "none", -- Border around the notification window
        zindex = 45, -- Stacking priority of the notification window
        max_width = 0, -- Maximum width of the notification window
        max_height = 0, -- Maximum height of the notification window
        x_padding = 1, -- Padding from right edge of window boundary
        y_padding = 0, -- Padding from bottom edge of window boundary
        align = "bottom", -- How to align the notification window
        relative = "editor", -- What the notification window position is relative to
      },
    },
  }
end

return M
```

And in the `init/lua`

```
...
spec("user.fidget")
...
```

### Gitsign

Edit the `~/.config/nvim/lua/user/gitsigns.lua` file
```
local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local icons = require "user.icons"

  local wk = require "which-key"
  wk.add {
    -- {
    --   "<leader>g",
    --   group = " Git",
    --   icon = {
    --     icon = " ",
    --     color = "azure",
    --   },
    -- },
    {
      "<leader>gj",
      "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
      desc = "Prev Hunk"
    },
    {
      "<leader>gk",
      "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
      desc = "Next Hunk"
    },
    {
      "<leader>gp",
      "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
      desc = "Preview Hunk"
    },
    {
      "<leader>gr",
      "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
      desc = "Reset Hunk"
    },
    {
      "<leader>gl",
      "<cmd>lua require 'gitsigns'.blame_line()<cr>",
      desc = "Blame"
    },
    {
      "<leader>gR",
      "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
      desc = "Reset Buffer"
    },
    {
      "<leader>gs",
      "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
      desc = "Stage Hunk"
    },
    {
      "<leader>gu",
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      desc = "Undo Stage Hunk"
    },
    {
      "<leader>gd",
      "<cmd>Gitsigns diffthis HEAD<cr>",
      desc = "Git Diff"
    },
  }

  require("gitsigns").setup {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hu', gitsigns.undo_stage_hunk)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      map('n', '<leader>td', gitsigns.toggle_deleted)

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
end

return M
```

And add the call from  `init.lua`
```
...
spec("user.gitsign")
```

### Markdown 
I first installed yarn with the command `npm install -g yarn`, after this I create a file `~/.config/nvim/lua/user/markdown.lua` with this:  
```
local M = {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  lazy = false, --
}

function M.config()

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- MarkdownToggle
  keymap("n", "<Leader>m", ":MarkdownPreviewToggle<CR>", opts)
  local ft = { "markdown" }
  vim.cmd("let g:mkdp_theme = 'dark'")
end

return M
```

And add the call from `init.lua`
```
...
spec("user.markdown")
```
