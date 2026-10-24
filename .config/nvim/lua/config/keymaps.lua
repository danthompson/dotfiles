-- disable keys
vim.keymap.set("", "<F1>", "<nop>")
vim.keymap.set("", "<Left>", "<nop>")
vim.keymap.set("", "<Right>", "<nop>")
vim.keymap.set("", "<Up>", "<nop>")
vim.keymap.set("", "<Down>", "<nop>")

-- window + buffer navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the window above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })
vim.keymap.set("n", "<leader>w", "<Cmd>set invwrap wrap?<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate buffer" })

-- completion: <CR> accepts the selected item, otherwise inserts a newline
local function enter_keys()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end

vim.keymap.set("i", "<CR>", enter_keys, { expr = true, desc = "Accept completion or newline" })

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

-- restart and restore the session, same as ZR
vim.keymap.set("n", "<leader>sv", "<Cmd>restart<CR>", { desc = "Restart Neovim" })

-- commands (defined in commands.lua)
vim.keymap.set("n", "<leader>fj", "<Cmd>FormatJSON<CR>", { desc = "Format JSON" })
-- ":" instead of <Cmd> so visual mode passes the selected lines as the range
vim.keymap.set({ "n", "x" }, "<leader>crp", ":CopyRelativePath<CR>", { silent = true, desc = "Copy relative path" })
vim.keymap.set({ "n", "x" }, "<leader>cap", ":CopyAbsolutePath<CR>", { silent = true, desc = "Copy absolute path" })
vim.keymap.set({ "n", "x" }, "<leader>chp", ":CopyRelativePathFromHome<CR>", { silent = true, desc = "Copy home path" })
vim.keymap.set({ "n", "x" }, "<leader>cgp", ":CopyPermalink<CR>", { silent = true, desc = "Copy GitHub permalink" })
