--[[
  configs.lua
  See: https://neovim.io/doc/user/lsp.html#lsp-config
--]]

-- see: https://neovim.io/doc/user/diagnostic.html
-- see: https://stackoverflow.com/a/70760302/17550686
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
}

-- show line diagnostics automatically in hover window
vim.cmd [[ autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false}) ]]

vim.fn.sign_define(
  "DiagnosticSignError",
  { text = "", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { text = "", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { text = "", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint" }
)
