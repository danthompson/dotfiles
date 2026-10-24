-- name: ty
-- desc: Extremely fast Python type checker written in Rust
-- homepage: https://docs.astral.sh/ty
--
-- install: brew install ty

return {
  cmd = {
    "ty",
    "server",
  },
  filetypes = {
    "python",
  },
  root_markers = {
    "ty.toml",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
}
