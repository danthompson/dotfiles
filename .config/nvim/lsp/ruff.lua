-- name: ruff
-- desc: Extremely fast Python linter written in Rust
-- homepage: https://docs.astral.sh/ruff/
--
-- install: brew install ruff

return {
  cmd = {
    "ruff",
    "server",
  },
  filetypes = {
    "python",
  },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
}
