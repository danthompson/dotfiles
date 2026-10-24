-- install: brew install tree-sitter-cli

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
    data = {
      -- installed parsers must match the plugin version
      update = function()
        vim.cmd("TSUpdate")
      end,
    },
  },
})

local treesitter = require("nvim-treesitter")

local languages = {
  "bash",
  "diff",
  "dockerfile",
  "gdscript",
  "git_config",
  "gitcommit",
  "gitignore",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "ruby",
  "rust",
  "sql",
  "terraform",
  "toml",
  "typescript",
  "yaml",
}

-- keep dependencies (e.g. terraform requires hcl) when removing unlisted languages
local function uninstall_unlisted_languages()
  local wanted = require("nvim-treesitter.config").norm_languages(languages)
  local unwanted = {}
  for _, lang in ipairs(treesitter.get_installed()) do
    if not vim.list_contains(wanted, lang) then
      table.insert(unwanted, lang)
    end
  end

  if #unwanted > 0 then
    treesitter.uninstall(unwanted)
  end
end

-- highlighting and indentation are opt-in per buffer
local function start_treesitter(args)
  if not pcall(vim.treesitter.start, args.buf) then
    return
  end

  -- without an indents query, the indentexpr is worse than the regex indent scripts
  local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
  if lang and vim.treesitter.query.get(lang, "indents") then
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

treesitter.install(languages)
uninstall_unlisted_languages()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = start_treesitter,
})
