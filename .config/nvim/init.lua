-- leader
vim.g.mapleader = ","

-- file handling
vim.opt.fileencoding = "utf-8"
vim.opt.undofile = true -- persistent undo
vim.opt.hidden = true -- keep buffers in memory
vim.opt.swapfile = false -- no swap files
vim.opt.writebackup = false -- no backup before overwriting
vim.opt.backup = false

-- clipboard + input
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.joinspaces = false

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
vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes" -- reserve column for diagnostics
vim.opt.cursorline = true

-- syntax + navigation
vim.opt.timeoutlen = 400
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99

-- statusline + visuals
vim.opt.showmatch = true
vim.opt.colorcolumn = "81"
vim.opt.textwidth = 78

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

-- search behavior
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- file + binary defaults
vim.opt.confirm = true -- confirm to save changes
vim.opt.termguicolors = true

-- plugins

-- lazy.nvim bootstrap
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repo = "https://github.com/folke/lazy.nvim.git"
  local response = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazy_repo,
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {
        "Failed to clone lazy.nvim:\n",
        "ErrorMsg",
      },
      {
        response,
        "WarningMsg",
      },
      {
        "\nPress any key to exit...",
      },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "stevearc/conform.nvim",
  },
  {
    "mfussenegger/nvim-lint",
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>v", ":TestVisit<CR>", { noremap = true, silent = true })
      vim.g["test#strategy"] = "neovim"
    end,
  },
  {
    "meanderingprogrammer/render-markdown.nvim",
  },
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        show_info = false,
        show_prompt = false,

        keymap_fim_trigger = "<C-f>",
        keymap_fim_accept_full = "<Tab>",
        keymap_fim_accept_line = "<A-l>",
        keymap_fim_accept_word = "<A-w>",

        keymap_fim_next = "<C-j>",
        keymap_fim_prev = "<C-k>",
        keymap_fim_cancel = "<C-\\>",
      }
    end,
    config = function()
      vim.api.nvim_set_hl(0, "llama_hl_fim_hint", { fg = "#808080" })
      vim.api.nvim_set_hl(0, "llama_hl__fim_info", { fg = "#808080" })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
  },
  {
    "RostislavArts/naysayer.nvim",
  },
  {
    "projekt0n/github-nvim-theme",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "morhetz/gruvbox",
  },
  {
    "airblade/vim-gitgutter",
  },
}, {
  ui = {
    border = "rounded",
  },
})

-- lsp + mason
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      noremap = true,
    })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "<leader>e", vim.diagnostic.open_float)
end

local servers = {
  ruby_lsp = {},
  pyright = {},
  terraformls = {},
  sqls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
            "require",
          },
        },
        workspace = {
          library = vim.env.VIMRUNTIME,
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  ts_ls = {},
}

mason.setup()
mason_lsp.setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.on_attach = on_attach
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      vim.lsp.config(server_name, server)
    end,
  },
})

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { noremap = true, silent = true })
vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { noremap = true, silent = true })

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- completion
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
    },
  }),
})

-- treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "lua",
    "vim",
    "vimdoc",
    "ruby",
    "python",
    "javascript",
    "typescript",
    "sql",
    "terraform",
    "gdscript",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- telescope
require("telescope").setup({
  defaults = {
    layout_config = {
      width = 0.95,
      height = 0.90,
    },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
})

local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", function()
  tb.find_files({ hidden = true })
end, {
  silent = true,
})
vim.keymap.set("n", "<leader>r", tb.live_grep, {
  silent = true,
})
vim.keymap.set("n", "<leader>b", tb.buffers, {
  silent = true,
})

-- window + buffer navigation keybindings
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "<leader>w", ":set invwrap wrap?<CR>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("n", "<leader><leader>", "<C-^>", {
  noremap = true,
  silent = true,
})

-- search navigation keybindings
vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", {
  noremap = true,
  silent = true,
})

-- disable arrows keybindings
vim.keymap.set("", "<F1>", "<nop>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("", "<Left>", "<nop>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("", "<Right>", "<nop>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("", "<Up>", "<nop>", {
  noremap = true,
  silent = true,
})
vim.keymap.set("", "<Down>", "<nop>", {
  noremap = true,
  silent = true,
})

-- aliases keybindings
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Bd", "bd", {})

-- format
vim.keymap.set("n", "<leader>F", function()
  require("conform").format({
    async = true,
    lsp_fallback = true,
  })
end, {
  noremap = true,
  silent = true,
})

-- lint
vim.keymap.set("n", "<leader>L", function()
  require("lint").try_lint()
end, {
  noremap = true,
  silent = true,
})

-- reload / source configuration
vim.keymap.set("n", "<leader>sv", function()
  local cfg = vim.fn.stdpath("config") .. "/init.lua"
  dofile(cfg)
  vim.notify("Reloaded " .. cfg, vim.log.levels.INFO, {
    title = "nvim",
  })
end, {
  noremap = true,
  silent = true,
})

-- formatting
require("conform").setup({
  formatters_by_ft = {
    ruby = {
      "rubocop",
    }, -- or "standardrb" if you prefer
    python = {
      "ruff_format",
    },
    javascript = {
      "prettier",
    },
    typescript = {
      "prettier",
    },
    sql = { "sqlfluff" },
    terraform = {
      "terraform_fmt",
    },
    lua = {
      "stylua",
    },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
})

-- linting
local lint = require("lint")
lint.linters_by_ft = {
  ruby = {
    "rubocop",
  },
  python = {
    "ruff",
  },
  javascript = {
    "eslint",
  },
  typescript = {
    "eslint",
  },
  sql = { "sqlfluff" },
  terraform = {
    "tflint",
  },
}
-- lint after write
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    require("lint").try_lint()
  end,
})

--
-- format json with jq
--

vim.api.nvim_create_user_command("FormatJSON", function()
  vim.cmd("%!jq .")
end, { nargs = 0, force = true })

vim.keymap.set("n", "<leader>fj", ":FormatJSON<CR>", { noremap = true, silent = true })

--
-- copy buffer path to clipboard
--

local function copy_path(opts)
  local raw = vim.fn.expand("%")
  local path = vim.fn.fnamemodify(raw, opts)
  vim.fn.setreg("+", path)
  vim.api.nvim_echo({ { "Copied: " .. path } }, false, {})
end

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  copy_path(":p")
end, { nargs = 0, force = true })

vim.api.nvim_create_user_command("CopyRelativePath", function()
  copy_path(":.")
end, { nargs = 0, force = true })

vim.api.nvim_create_user_command("CopyRelativePathFromHome", function()
  copy_path(":~")
end, { nargs = 0, force = true })

vim.keymap.set("n", "<leader>crp", ":CopyRelativePath<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cap", ":CopyAbsolutePath<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>chp", ":CopyRelativePathFromHome<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("StripWhitespace", ":%s/\\s\\+$//e", {})
vim.keymap.set("n", "<leader>ss", ":StripWhitespace<CR>", { noremap = true, silent = true })

-- vim.cmd("colorscheme Nightfox")
-- vim.cmd("colorscheme DayFox")
-- vim.cmd("colorscheme Terafox")
-- vim.cmd.colorscheme("naysayer")

-- vim.opt.background = "light"
-- vim.cmd("highlight Normal ctermbg=white guibg=white")
