--[[
  dependencies
  brew install ripgrep fd
--]]

--[[
  options
  See: https://neovim.io/doc/user/options.html
  See: https://neovim.io/doc/user/quickref.html#option-list
  See: https://neovim.io/doc/user/lua.html#lua-options
--]]

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

--[[
  plugins
  see: https://github.com/wbthomason/packer.nvim#bootstrapping
  see: https://github.com/wbthomason/packer.nvim#sequencing
--]]

local ensure_packer = function()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path
    }
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    -- utilities
    use "nvim-lua/plenary.nvim"
    use "nvim-tree/nvim-web-devicons"
    use "tpope/vim-fugitive"
    use "folke/which-key.nvim"
    use "folke/trouble.nvim"
    use "folke/todo-comments.nvim"
    use "lewis6991/gitsigns.nvim"
    use "windwp/nvim-autopairs"

    -- colorscheme
    use "gruvbox-community/gruvbox"

    -- treesitter (better syntax highlighting)
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update { with_sync = true }
      end
    }

    -- fuzzy-finding
    use "nvim-telescope/telescope.nvim"
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = vim.fn.executable "make" == 1,
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    }

    -- terminal
    use "akinsho/toggleterm.nvim"

    -- lines
    use "lukas-reineke/indent-blankline.nvim"
    use "akinsho/bufferline.nvim"
    use "nvim-lualine/lualine.nvim"

    -- lsp
    use "williamboman/mason.nvim"
    use "WhoIsSethDaniel/mason-tool-installer.nvim"
    use "neovim/nvim-lspconfig"

    -- linter/formatter
    use "jose-elias-alvarez/null-ls.nvim"

    -- auto-completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"

    -- snippets
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    }
  }
}

-- set colorscheme
vim.cmd [[ colorscheme gruvbox ]]

--[[
  setups
--]]

require("which-key").setup {}
require("trouble").setup {
  use_diagnostic_signs = true,
}
require("todo-comments").setup {}
require("gitsigns").setup {}
require("nvim-autopairs").setup {}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "go", "lua", "query", "typescript" },
  highlight = { enable = true },
  indent = { enable = true },
}

require("telescope").setup {}

require("toggleterm").setup {
  tag = "*"
}

require("ibl").setup {
  indent = { tab_char = "⇥" },
}
require("bufferline").setup {
  options = {
    numbers = "ordinal",
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}
require("lualine").setup {
  options = {
    icons_enabled = false,
    theme = "gruvbox",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "branch",
        fmt = function(str)
          if (str == "") then
            return str
          end
          return "" .. " " .. str
        end
      },
      "diff",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
        severity_sort = true,
        update_in_insert = true,
      },
    },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}

require("mason").setup {}
require("mason-tool-installer").setup {
  ensure_installed = {
    -- lsps
    "lua-language-server",
    "gopls",
    "typescript-language-server",
    "rust-analyzer",
    -- linter
    "luacheck",
    "golangci-lint",
    "eslint_d",
    -- formatter
    "luaformatter",
    "goimports",
    "prettierd",
  }
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["sumneko_lua"].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
require("lspconfig")["gopls"].setup {
  capabilities = capabilities,
}
require("lspconfig")["tsserver"].setup {
  capabilities = capabilities,
}
require("lspconfig")["rust_analyzer"].setup {
  capabilities = capabilities,
}

require("null-ls").setup {
  sources = {
    -- code actions
    require("null-ls").builtins.code_actions.eslint_d,
    require("null-ls").builtins.code_actions.gitsigns,
    -- diagnostics
    require("null-ls").builtins.diagnostics.eslint_d,
    require("null-ls").builtins.diagnostics.golangci_lint,
    require("null-ls").builtins.diagnostics.luacheck.with {
      extra_args = { "--globals", "vim" },
    },
    -- formatting
    require("null-ls").builtins.formatting.goimports,
    require("null-ls").builtins.formatting.lua_format,
    require("null-ls").builtins.formatting.prettierd,
  },
  update_in_insert = true,
}

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

--[[
  configs
--]]

vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
}

vim.cmd [[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]]
vim.cmd [[
  autocmd BufWritePre *.ts lua vim.lsp.buf.format({ async = true })
  autocmd BufWritePre *.rs lua vim.lsp.buf.format({ async = true })
]]

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

--[[
  keymaps
--]]

-- set leader key to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bind <Space> to <Nop>
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- see `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
