vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = vim.version.range("2.*") },
})

local gitsigns = require("gitsigns")

-- commit the signs are diffed against, nil for the index
local branch_base = nil

-- show the whole branch's changes (e.g. to review a PR) instead of uncommitted ones
local function toggle_branch_base()
  if branch_base then
    branch_base = nil
    gitsigns.reset_base(true)
    vim.notify("Signs: uncommitted changes")
    return
  end

  local result = vim
    .system({ "git", "merge-base", "HEAD", "origin/HEAD" }, {
      cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
      text = true,
    })
    :wait()
  if result.code ~= 0 then
    vim.notify("No merge base with origin/HEAD: " .. vim.trim(result.stderr), vim.log.levels.WARN)
    return
  end

  branch_base = vim.trim(result.stdout)
  gitsigns.change_base(branch_base, true)
  vim.notify("Signs: changes since " .. branch_base:sub(1, 7))
end

-- in diff mode, keep the built-in ]c/[c change jumps
local function jump_next_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    gitsigns.nav_hunk("next")
  end
end

local function jump_prev_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    gitsigns.nav_hunk("prev")
  end
end

local function set_buffer_keymaps(buffer)
  vim.keymap.set("n", "]c", jump_next_hunk, { buffer = buffer, desc = "Next hunk" })
  vim.keymap.set("n", "[c", jump_prev_hunk, { buffer = buffer, desc = "Previous hunk" })
  vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = buffer, desc = "Stage hunk" })
  vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = buffer, desc = "Reset hunk" })
  vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = buffer, desc = "Preview hunk" })
  vim.keymap.set("n", "<leader>hb", function()
    gitsigns.blame_line({ full = true })
  end, { buffer = buffer, desc = "Blame line" })
  vim.keymap.set("n", "<leader>hB", toggle_branch_base, { buffer = buffer, desc = "Toggle branch changes" })
end

gitsigns.setup({
  on_attach = set_buffer_keymaps,
})
