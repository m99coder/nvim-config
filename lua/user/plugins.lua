--[[
  plugins.lua
  see: https://github.com/wbthomason/packer.nvim#bootstrapping
  see: https://github.com/wbthomason/packer.nvim#sequencing

  Setup is targeting the following programming languages:
    - Go
    - Lua
    - Python
    - Rust
    - JavaScript/TypeScript
--]]

-- clone packer repository and return boolean flag indicating
-- if packer was just bootstraped
local ensure_packer = function()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- automatically run `:PackerSync` whenever `plugins.lua` is updated
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- require packer and packer.util
local packer = require("packer")
local packer_util = require("packer.util")

-- define plugins
return packer.startup {
  function(use)
    -- packer plugin itself
    use "wbthomason/packer.nvim"

    -- utility plugins
    use "nvim-lua/plenary.nvim"
    use "nvim-tree/nvim-web-devicons"
    use "tpope/vim-fugitive"

    -- colorscheme
    use {
      "ellisonleao/gruvbox.nvim",
      config = function()
        vim.cmd [[ colorscheme gruvbox ]]
      end
    }

    -- treesitter (AST)
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update { with_sync = true }
      end,
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "go", "lua", "python", "rust", "typescript" },
          highlight = { enable = true },
          indent = { enable = true },
        }
      end
    }

    -- fuzzy-finding with `fzf`
    use {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = { "plenary.nvim" },
      config = function()
        require("telescope").setup {}
      end
    }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cond = vim.fn.executable "make" == 1,
      config = function()
        require("telescope").load_extension("fzf")
      end
    }

    -- buffers, windows, columns, and lines
    use {
      "lukas-reineke/indent-blankline.nvim",
      after = { "nvim-treesitter" },
      config = function()
        -- `show_current_context` requires treesitter
        require("indent_blankline").setup {
          show_current_context = true,
          show_current_context_start = false,
          show_end_of_line = true,
          space_char_blankline = " ",
        }
      end
    }
    use {
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      requires = { "nvim-web-devicons" },
      after = { "gruvbox.nvim" },
      config = function()
        require("bufferline").setup {
          options = {
            numbers = "ordinal",
            show_buffer_icons = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
          },
        }
      end
    }
    use {
      "nvim-lualine/lualine.nvim",
      after = { "gruvbox.nvim", "vim-fugitive" },
      config = function()
        -- see: https://github.com/nvim-lualine/lualine.nvim#default-configuration
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
              -- see: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/extensions/fugitive.lua
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
              -- see: https://github.com/nvim-lualine/lualine.nvim#diagnostics-component-options
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
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup {}
      end
    }
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    }
    use {
      "folke/trouble.nvim",
      after = { "gruvbox.nvim" },
      config = function()
        require("trouble").setup {
          -- auto_close = true,
          -- auto_open = true,
          use_diagnostic_signs = true,
        }
      end
    }
    use {
      "folke/todo-comments.nvim",
      config = function()
        -- can be combined with `Trouble` like this:
        -- :TodoTrouble cwd=~/.config/nvim
        require("todo-comments").setup {}
      end
    }

    -- lsp, dsp, linter, formatter, and auto-completion
    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup {}
      end
    }
    use {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      after = { "mason.nvim" },
      config = function()
        -- see: https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
        -- lua packages require `luarocks`
        require("mason-tool-installer").setup {
          ensure_installed = {
            -- lsps
            "lua-language-server",
            "gopls",
            "pyright",
            "rust-analyzer",
            "typescript-language-server",
            -- linter
            "luacheck",
            "golangci-lint",
            "pylint",
            "eslint_d",
            -- formatter
            "luaformatter",
            "goimports",
            "black",
            -- no formatter for rust found
            "prettierd",
          }
        }
      end
    }
    -- TODO: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
    use {
      "neovim/nvim-lspconfig",
      after = { "mason-tool-installer.nvim" },
      config = function()
        -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
        require("lspconfig")["sumneko_lua"].setup {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
        }
        require("lspconfig")["gopls"].setup {}
        require("lspconfig")["pyright"].setup {}
        require("lspconfig")["rust_analyzer"].setup {}
        -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
        require("lspconfig")["tsserver"].setup {
          -- enable lsp for stand-alone files as well
          -- see: https://www.reddit.com/r/neovim/comments/px8ast/comment/heltpty
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("tsconfig.json")(fname)
                or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
                or util.path.dirname(fname)
          end
        }
      end
    }
    -- additionally https://github.com/jayp0521/mason-null-ls.nvim
    -- could be used to simplify the matching of the different names
    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "plenary.nvim" },
      config = function()
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
            require("null-ls").builtins.diagnostics.pylint,
            -- formatting
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.goimports,
            require("null-ls").builtins.formatting.lua_format,
            require("null-ls").builtins.formatting.prettierd,
          },
          update_in_insert = true,
        }
      end
    }

    -- sync
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      -- using a floating window
      open_fn = packer_util.float,
    }
  }
}
