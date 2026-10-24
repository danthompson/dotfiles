vim.pack.add({
  { src = "https://github.com/vim-test/vim-test", version = vim.version.range("3.*") },
})

-- run in a :terminal split
vim.g["test#strategy"] = "neovim"

vim.keymap.set("n", "<leader>t", "<Cmd>TestNearest<CR>", { desc = "Test nearest" })
vim.keymap.set("n", "<leader>T", "<Cmd>TestFile<CR>", { desc = "Test file" })
vim.keymap.set("n", "<leader>a", "<Cmd>TestSuite<CR>", { desc = "Test suite" })
vim.keymap.set("n", "<leader>l", "<Cmd>TestLast<CR>", { desc = "Test last" })
vim.keymap.set("n", "<leader>v", "<Cmd>TestVisit<CR>", { desc = "Visit last test file" })
