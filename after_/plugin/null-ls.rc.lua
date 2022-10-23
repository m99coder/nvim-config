--[[
  null-ls.rc.lua
--]]

local status, null_ls = pcall(require, "null-ls")
if (not status) then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettierd,
  },
  update_in_insert = true,
}

-- keymap for code action and format
vim.keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { silent = true })
