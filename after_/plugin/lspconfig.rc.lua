--[[
  lspconfig.rc.lua
--]]

local status_util, util = pcall(require, "lspconfig/util")
if (not status_util) then
  return
end

local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status_mason_lspconfig) then
  return
end

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if (not status_lspconfig) then
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
  }
}

-- See: https://github.com/neovim/nvim-lspconfig#suggested-configuration
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- lua
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- typescript
lspconfig.tsserver.setup {
  -- See: https://www.reddit.com/r/neovim/comments/px8ast/comment/heltpty
  root_dir = function(fname)
    return util.root_pattern("tsconfig.json")(fname)
        or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
        or util.path.dirname(fname)
  end
}

-- configure diagnostics
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
}

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
