--[[
  mason-tool-installer.rc.lua
--]]

local status, mason_tool_installer = pcall(require, "mason-tool-installer")
if (not status) then
  return
end

mason_tool_installer.setup {
  ensure_installed = {
    "eslint_d",
    "prettierd",
  }
}
