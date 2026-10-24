-- with nowrap, virtual text cuts off long messages, so show the full one on ]d/[d/]e/[e
local function open_diagnostic_float(diagnostic, buffer)
  if diagnostic then
    vim.diagnostic.open_float({ bufnr = buffer, scope = "cursor", focus = false })
  end
end

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = {
    source = "if_many",
  },
  jump = {
    on_jump = open_diagnostic_float,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "»",
      [vim.diagnostic.severity.HINT] = "•",
    },
  },
})

-- like ]d/[d, but skips warnings and hints
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to the next error" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Jump to the previous error" })
