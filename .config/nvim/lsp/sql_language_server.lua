-- name: sql-language-server
-- desc: Language Server for SQL
-- homepage: https://github.com/joe-re/sql-language-server
--
-- install: brew install sql-language-server

return {
  cmd = {
    "sql-language-server",
    "up",
    "--method",
    "stdio",
  },
  filetypes = {
    "sql",
    "mysql",
  },
  root_markers = {
    ".sqllsrc.json",
  },
}
