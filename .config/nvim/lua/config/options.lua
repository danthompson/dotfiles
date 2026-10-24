-- messages
vim.opt.shortmess:append("sI")

-- clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- ui
local ui = require("vim._core.ui2")
ui.enable({
  enable = true,
  msg = {
    targets = "cmd",
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.5,
    },
    pager = {
      height = 1,
    },
  },
})

-- autocompletion: menu opens as you type, <C-n>/<C-p> to move, <C-y> to accept
-- LSP buffers add the server as a source (lua/config/lsp.lua)
vim.opt.autocomplete = true
vim.opt.complete = { ".", "w", "b" }
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy" }

-- file handling
vim.opt.fileencoding = "utf-8"
vim.opt.undofile = true -- persistent undo
vim.opt.swapfile = false
vim.opt.writebackup = false -- no backup before overwriting
vim.opt.confirm = true -- ask to save changes instead of failing
vim.opt.exrc = true -- run a project's .nvim.lua once approved, see :help :trust

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tabs + indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- appearance + layout
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5
vim.opt.wrap = false
vim.opt.linebreak = true -- when wrap is toggled on, break at word boundaries
vim.opt.breakindent = true -- and keep the indent on continued lines
vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes" -- reserve column for diagnostics
vim.opt.cursorline = true
vim.opt.winborder = "rounded" -- floating windows
vim.opt.pumborder = "rounded" -- completion menu
vim.opt.termguicolors = true
vim.opt.showmatch = true
vim.opt.colorcolumn = "121"
vim.opt.textwidth = 78

-- timing
vim.opt.timeoutlen = 400
vim.opt.updatetime = 250 -- CursorHold delay, used by LSP reference highlights

-- window behavior
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.laststatus = 3 -- global statusline

-- lists + whitespace indicators
vim.opt.list = true
vim.opt.listchars = {
  tab = "| ",
  trail = "·",
  extends = ">",
  precedes = "<",
  nbsp = "·",
}
