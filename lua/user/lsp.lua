local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok, masonLspConfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

mason.setup()
masonLspConfig.setup({
  ensure_installed = { "tsserver" }
})
