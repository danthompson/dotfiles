-- big files get the "bigfile" filetype, so treesitter, LSP and ftplugins never start.
-- regex syntax still highlights them, unless lines are long (e.g. minified JSON)
local BIG_FILE_BYTES = 1.5 * 1024 * 1024
local LONG_LINE_BYTES = 1000

local function big_file_filetype(path, buffer)
  -- vim.filetype.match below runs this again, and must get the real filetype
  if buffer and vim.bo[buffer].filetype ~= "bigfile" and vim.fn.getfsize(path) > BIG_FILE_BYTES then
    return "bigfile"
  end
end

local function configure_big_file(args)
  local buffer = args.buf
  -- completion would scan the whole buffer for words
  vim.bo[buffer].autocomplete = false

  local bytes_per_line = vim.fn.getfsize(args.file) / vim.api.nvim_buf_line_count(buffer)
  if bytes_per_line < LONG_LINE_BYTES then
    -- after the FileType autocmd that sets syntax to "bigfile"
    vim.schedule(function()
      vim.bo[buffer].syntax = vim.filetype.match({ buf = buffer }) or ""
    end)
  end
end

vim.filetype.add({
  pattern = {
    [".*"] = {
      big_file_filetype,
      { priority = math.huge },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
  pattern = "bigfile",
  callback = configure_big_file,
})
