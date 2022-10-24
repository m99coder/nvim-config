# nvim-config

## Install dependencies

In order for `Telescope` to provide a feature-rich fuzzy-finding experience, it’s best to install some utilities beforehand.

```shell
brew install ripgred fd
```

## Options

The first section of the `init.lua` config file are the options. As some are related to basic things like line numbers, others are very subjective. Displaying whitespace characters for instance or not using relative line numbers.

```lua
local options = {
  breakindent = true,
  clipboard = "unnamedplus",
  completeopt = "menuone,noselect",
  confirm = true,
  cursorline = true,
  equalalways = false,
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = false,
  ignorecase = true,
  list = true,
  listchars = "tab:\\u279c\\u00b7,trail:·,nbsp:+,leadmultispace:·,space:·",
  number = true,
  scrolloff = 10,
  shiftwidth = 2,
  showtabline = 2,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  tabstop = 2,
  termguicolors = true,
  updatetime = 250,
  writebackup = false,
}

for k, v in pairs(options) do
  vim.o[k] = v
end
```

## Plugins

The configuration installs the following plugins:

|Plugin|Purpose|
|---|---|
|`wbthomason/packer.nvim`|Plugin package manager|
|`nvim-lua/plenary.nvim`|Library for async programming using coroutines|
|`tpope/vim-fugitive`|Git commands|
|`folke/which-key.nvim`|Helper window for keymaps|
|`folke/trouble.nvim`|Helper window for diagnostics|
|`folke/todo-comments.nvim`|Highlight special comments|
|`lewis6991/gitsigns.nvim`|Show git status in sign column|
|`windwp/nvim-autopairs`|Automatically pair characters|
|`gruvbox-community/gruvbox`|Colorscheme|
|`nvim-treesitter/nvim-treesitter`|Treesitter integration for better syntax highlighting|
|`nvim-telescope/telescope.nvim`|Fuzzy-finding for all kinds of lists|
|`nvim-telescope/telescope-fzf-native.nvim`|Fuzzy-finding using `fzf-native`|
|`lukas-reineke/indent-blankline.nvim`|Show line for current context|
|`akinsho/bufferline.nvim`|Show buffer line on top|
|`nvim-lualine/lualine.nvim`|Show lua line on bottom|
|`williamboman/mason.nvim`|LSP package manager|
|`WhoIsSethDaniel/mason-tool-installer.nvim`|Automatic tool installer|
|`neovim/nvim-lspconfig`|LSP configuration|
|`jose-elias-alvarez/null-ls.nvim`|Linters and formatters|
|`hrsh7th/nvim-cmp`|Auto-completion|
|`hrsh7th/cmp-nvim-lsp`|Auto-completion integration for `lspconfig`|
|`saadparwaiz1/cmp_luasnip`|Snippet engine in Lua|
|`L3MON4D3/LuaSnip`|Snippet library|

## Setups

Most of the plugins are used as they come. For some a special configuration is added.

* Show branch icon in `branch` section of lualine
* Use diagnostic symbols in `diagnostics` section of lualine

## Configs

The included configurations are kept minimal for now. Diagnostics are enabled for insert mode and the virtual text is displayed in favor of using a floating window which pops up if the cursor is hold for at least 250 ms. Autoformat is set up as soon as a buffer is written to disk (file is saved). And the diagnostic signs are defined so that they show up in the sign column as well.

## Keymaps

The final part contains some basic keymappings. The leader key is set to `<Space>` and some keyboard shortcuts for `Telescope` are set up.
