--[[
  lualine.rc.lua
--]]

local status, lualine = pcall(require, "lualine")
if (not status) then
  return
end

lualine.setup({
  options = {
    icons_enabled = false,
    theme = "gruvbox",
    component_separators = "·",
    section_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      -- https://github.com/nvim-lualine/lualine.nvim#filename-component-options
      {
        "filename",
        -- displays file status (readonly, modified, …)
        file_status = true,
        -- displays just filename (1 = relative, 2 = absolute path)
        path = 0,
      }
    },
    lualine_x = {
      -- https://github.com/nvim-lualine/lualine.nvim#diagnostics-component-options
      {
        "diagnostics",
        sources = {
          "nvim_diagnostic"
        },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " "
        },
        severity_sort = true,
        update_in_insert = true,
      },
      "encoding",
      "filetype"
    },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      -- https://github.com/nvim-lualine/lualine.nvim#filename-component-options
      {
        "filename",
        -- displays file status (readonly, modified, …)
        file_status = true,
        -- displays relative path (0 = just filename, 2 = absolute path)
        path = 1
      }
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  -- TODO: check if this works
  extensions = { "fugitive" }
})
