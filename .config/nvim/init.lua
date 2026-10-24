-- use module caching
vim.loader.enable()

-- leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- configuration. plugin/*.lua loads after this, so pack hooks exist before vim.pack.add
require("config.options")
require("config.keymaps")
require("config.commands")
require("config.autocommands")
require("config.bigfile")
require("config.pack")
require("config.lsp")
require("config.diagnostics")
