-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don’t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Init (maybe unnecessary)
--packer.init {}

-- Install plugins
return packer.startup(function(use)
  use "wbthomason/packer.nvim"    -- Have packer manage itself
  --use "nvim-lua/popup.nvim"       -- An implementation of the Popup API from vim in Neovim
  --use "nvim-lua/plenary.nvim"     -- Useful lua functions used by lots of plugins

  -- auto-completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  
  -- snippet engine
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- language server protocol (LSP)
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"

  -- themes
  use "ellisonleao/gruvbox.nvim"  -- gruvbox theme
  --use "rktjmp/lush.nvim"          -- colorscheme creation aid for Neovim
  --use "davidscotson/sonokai-nvim" -- sonokai theme

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
