--[[
  bufferline.rc.lua
--]]

local status, bufferline = pcall(require, "bufferline")
if (not status) then
  return
end

bufferline.setup({
  options = {
    numbers = "ordinal",
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
  }
})
