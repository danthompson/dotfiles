-- name: lua-language-server
-- desc: Language Server for the Lua language
-- homepage: https://luals.github.io
--
-- install: brew install lua-language-server

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        ignoreSubmodules = true,
        library = {
          vim.env.VIMRUNTIME, -- neovim `vim.*`
        },
      },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        globals = {
          "vim",
          "rex",
        },
      },
    },
  },
}
