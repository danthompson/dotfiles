vim.lsp.enable({
  "bashls",
  "lua_ls",
  "marksman",
  "ruby_lsp",
  "ruff",
  -- "sql_language_server",
  "terraformls",
  "tombi",
  "ty",
  "yamlls",
})

local function toggle_inlay_hints()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end

local function clear_document_highlight(args)
  vim.lsp.buf.clear_references()
  vim.api.nvim_del_augroup_by_name("lsp_document_highlight_" .. args.buf)
end

-- mappings:
--   core defaults
--     grn → rename
--     gra → code action (normal + visual)
--     grr → references
--     gri → implementation
--     grt → type definition
--     gO → document symbols
--     <C-s> (insert mode) → signature help
--     K → hover docs
--     gq → format range
--     ]d / [d → next / previous diagnostic
--     <C-w>d → diagnostic float
--   added here
--     gd → definition
--     gD → declaration
--     <leader>uh → toggle inlay hints
local function setup_lsp_buffer(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not client then
    return
  end
  local buffer = event.buf

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Go to declaration" })

  if client:supports_method("textDocument/documentHighlight") then
    -- highlight other references to the symbol under the cursor
    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. buffer, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = group,
      buffer = buffer,
      callback = clear_document_highlight,
    })
  end

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
    vim.keymap.set("n", "<leader>uh", toggle_inlay_hints, { buffer = buffer, desc = "Toggle inlay hints" })
  end

  if client:supports_method("textDocument/completion") then
    -- <C-y> applies the item's side effects (snippets, auto-imports)
    vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
    -- "o" is omnifunc, which LSP sets on attach. Only add it here, because without LSP
    -- some filetypes set a slow omnifunc (e.g. python3complete)
    vim.bo[buffer].complete = "o,.,w,b"
  end
end

-- core shows progress messages in the statusline, cmdline and Ghostty's progress bar,
-- but doesn't turn LSP progress (e.g. ruby-lsp indexing) into them
local function echo_lsp_progress(event)
  local value = event.data.params.value
  vim.api.nvim_echo({ { value.message or "done" } }, false, {
    id = "lsp." .. event.data.client_id .. "." .. event.data.params.token,
    kind = "progress",
    source = "vim.lsp",
    title = value.title,
    status = value.kind ~= "end" and "running" or "success",
    percent = value.percentage,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = setup_lsp_buffer,
})

vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("lsp_progress", { clear = true }),
  callback = echo_lsp_progress,
})
