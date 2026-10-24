-- name: tombi
-- desc: TOML formatter linter and language server
-- homepage: https://github.com/tombi-toml/tombi
--
-- install: brew install tombi

return {
  cmd = {
    "tombi",
    "lsp",
  },
  filetypes = {
    "toml",
  },
  root_markers = {
    "tombi.toml",
    "pyproject.toml",
    ".git",
  },
}
