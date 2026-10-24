vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")

fzf.setup({
  oldfiles = {
    cwd_only = true,
    include_current_session = true,
  },
})
fzf.register_ui_select()

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep files" })
vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word" })
vim.keymap.set("n", "<leader>fW", fzf.grep_cWORD, { desc = "Grep WORD" })
vim.keymap.set("n", "<leader>fu", fzf.undotree, { desc = "Undo tree" })
vim.keymap.set("n", "<leader>f.", fzf.resume, { desc = "Resume picker" })
