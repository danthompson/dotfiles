-- name: bash-language-server
-- desc: Language Server for Bash
-- homepage: https://github.com/bash-lsp/bash-language-server
--
-- install: brew install bash-language-server

return {
  cmd = {
    "bash-language-server",
    "start",
  },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  filetypes = {
    "bash",
    "sh",
  },
  root_markers = {
    ".git",
  },
}
