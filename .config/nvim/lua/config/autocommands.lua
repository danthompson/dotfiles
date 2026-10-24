-- toggle relative numbers on mode
local toggle_line_numbers = vim.api.nvim_create_augroup("toggle_line_numbers", { clear = true })
local function enable_relative_numbers()
  if vim.wo.number and not vim.startswith(vim.api.nvim_get_mode().mode, "i") then
    vim.wo.relativenumber = true
  end
end

local function disable_relative_numbers(args)
  if vim.wo.number then
    vim.wo.relativenumber = false
  end
  -- show the change before typing a command, but not for input() or :insert lines
  if args.event == "CmdlineEnter" and not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
    vim.cmd.redraw()
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  group = toggle_line_numbers,
  desc = "toggle relative line numbers on",
  callback = enable_relative_numbers,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  group = toggle_line_numbers,
  desc = "toggle relative line numbers off",
  callback = disable_relative_numbers,
})

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 200, visual = true })
  end,
})

-- show cursorline only in active window
local cursorline_group = vim.api.nvim_create_augroup("active_cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- restore cursor to file position in previous editing session
local function restore_cursor(args)
  local filetype = vim.bo[args.buf].filetype
  if filetype == "gitcommit" or filetype == "gitrebase" then
    return
  end
  local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
  local line_count = vim.api.nvim_buf_line_count(args.buf)
  if mark[1] > 0 and mark[1] <= line_count then
    vim.api.nvim_win_set_cursor(0, mark)
    -- defer centering slightly so it's applied after render
    vim.schedule(function()
      vim.cmd("normal! zz")
    end)
  end
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
  callback = restore_cursor,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  command = "wincmd =",
})

-- auto create path when saving file
local function create_parent_dir(event)
  -- skip URLs such as scp:// or oil://
  if event.match:match("^%w%w+:[\\/][\\/]") then
    return
  end
  local file = vim.uv.fs_realpath(event.match) or event.match
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = create_parent_dir,
})
