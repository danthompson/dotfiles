vim.pack.add({
  "https://github.com/lewis6991/async.nvim", -- only required for Neovim 0.12
  "https://github.com/theprimeagen/refactoring.nvim",
})

local refactor = require("refactoring")
local modes = { "n", "x" }

refactor.setup({})

vim.keymap.set(modes, "<leader>rE", refactor.extract_func_to_file, { desc = "Extract function to file", expr = true })
vim.keymap.set(modes, "<leader>rI", refactor.inline_func, { desc = "Inline function", expr = true })
vim.keymap.set(modes, "<leader>re", refactor.extract_func, { desc = "Extract function", expr = true })
vim.keymap.set(modes, "<leader>ri", refactor.inline_var, { desc = "Inline variable", expr = true })
vim.keymap.set(modes, "<leader>rv", refactor.extract_var, { desc = "Extract variable", expr = true })
