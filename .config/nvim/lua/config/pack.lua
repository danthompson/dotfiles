-- run a spec's install or update hook from its `data` field
local function run_pack_hook(event)
  local data = event.data.spec.data
  if not data then
    return
  end

  if not event.data.active then
    vim.cmd.packadd(event.data.spec.name)
  end

  local hook = vim.tbl_get(data, event.data.kind)
  if hook then
    hook(event)
  end
end

-- delete plugins no longer added by vim.pack.add. VimEnter runs after every plugin/*.lua
-- has called vim.pack.add, and with plugins off (--noplugin) all of them would look unused
local function delete_inactive_plugins()
  if not vim.go.loadplugins then
    return
  end

  local inactive = {}
  for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
    if not plugin.active then
      table.insert(inactive, plugin.spec.name)
    end
  end

  -- vim.pack.del reports each removed plugin
  if #inactive > 0 then
    vim.pack.del(inactive)
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("pack_hooks", { clear = true }),
  callback = run_pack_hook,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("pack_clean", { clear = true }),
  callback = delete_inactive_plugins,
})
