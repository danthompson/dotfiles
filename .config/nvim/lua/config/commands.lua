-- aliases
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Bd", "bd", {})

vim.api.nvim_create_user_command("FormatJSON", "%!jq .", {})

-- "12" or "12-15" from a command's range
local function line_range(opts)
  if opts.line1 == opts.line2 then
    return tostring(opts.line1)
  end
  return opts.line1 .. "-" .. opts.line2
end

-- copy the buffer's path to the clipboard, shaped by a fnamemodify() modifier.
-- given a range (visual selection or e.g. :.CopyRelativePath), appends :12 or :12-15
local function copy_path(modifier, opts)
  local path = vim.fn.expand("%" .. modifier)
  if opts.range > 0 then
    path = path .. ":" .. line_range(opts)
  end
  vim.fn.setreg("+", path)
  vim.api.nvim_echo({ { "Copied: " .. path } }, false, {})
end

-- link to the line or range at the HEAD commit, which must be pushed for the link to work
local function copy_permalink(opts)
  local file = vim.api.nvim_buf_get_name(0)
  local result = vim
    .system({ "gh", "browse", "--commit", "--no-browser", vim.fs.basename(file) .. ":" .. line_range(opts) }, {
      cwd = vim.fs.dirname(file),
      text = true,
    })
    :wait()
  if result.code ~= 0 then
    vim.notify("gh browse failed: " .. vim.trim(result.stderr), vim.log.levels.ERROR)
    return
  end

  local url = vim.trim(result.stdout)
  vim.fn.setreg("+", url)
  vim.api.nvim_echo({ { "Copied: " .. url } }, false, {})
end

vim.api.nvim_create_user_command("CopyAbsolutePath", function(opts)
  copy_path(":p", opts)
end, { range = true })

vim.api.nvim_create_user_command("CopyRelativePath", function(opts)
  copy_path(":.", opts)
end, { range = true })

vim.api.nvim_create_user_command("CopyRelativePathFromHome", function(opts)
  copy_path(":~", opts)
end, { range = true })

vim.api.nvim_create_user_command("CopyPermalink", copy_permalink, { range = true })
