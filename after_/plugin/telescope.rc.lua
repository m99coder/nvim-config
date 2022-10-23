--[[
  telescope.rc.lua
--]]

local status, telescope = pcall(require, "telescope")
if (not status) then
  return
end

--[[
telescope.setup {
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser instead
      hijack_netrw = true,
    },
  },
}

pcall(require("telescope").load_extension "file_browser")
pcall(require('telescope').load_extension "fzf")
--]]

telescope.setup()
