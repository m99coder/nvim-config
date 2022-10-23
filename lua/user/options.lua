-- :help options
local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  number = true,
  pumheight = 10,
  relativenumber = false,
  shiftwidth = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 300,
  wrap = false,
  writebackup = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- font used in graphical neovim applications
vim.opt.guifont = "MesloLGS NF:h14"

-- set language to English
vim.api.nvim_exec("language en_US", true)
