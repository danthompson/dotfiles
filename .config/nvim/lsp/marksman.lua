-- name: marksman
-- desc: Language Server Protocol for Markdown
-- homepage: https://github.com/artempyanykh/marksman
--
-- install: brew install marksman

return {
  cmd = {
    "marksman",
    "server",
  },
  filetypes = {
    "markdown",
    "markdown.mdx",
  },
  root_markers = {
    ".marksman.toml",
    ".git",
  },
}
