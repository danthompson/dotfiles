vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

-- conform formats on save when this returns options, and skips when it returns nil
local function format_on_save_opts()
  if vim.g.format_on_save == false then
    return nil
  end
  return {}
end

local function toggle_format_on_save()
  vim.g.format_on_save = vim.g.format_on_save == false
  vim.notify("Format on save " .. (vim.g.format_on_save and "on" or "off"))
end

conform.setup({
  default_format_opts = {
    lsp_format = "fallback",
    timeout = 2000,
  },
  format_on_save = format_on_save_opts,
  formatters_by_ft = {
    lua = {
      "stylua",
    },
    python = {
      "ruff_format",
    },
    ["*"] = {
      "trim_newlines",
      "trim_whitespace",
    },
    ["_"] = {
      lsp_format = "last",
    },
  },
  notify_on_error = true,
})

vim.keymap.set("n", "<leader>uf", toggle_format_on_save, { desc = "Toggle format on save" })
