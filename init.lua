-- Neovim Configuration
-- See: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- [[ Package Management ]]
-- See: https://github.com/wbthomason/packer.nvim#bootstrapping

local ensure_packer = function()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- Further plugins
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

  use 'folke/which-key.nvim'
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use 'tpope/vim-commentary'
  use 'tpope/vim-jdaddy'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use { 'hrsh7th/nvim-cmp', requires = 'hrsh7th/cmp-nvim-lsp' }

  use { 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end--[[,
config = {
  display = {
    -- Using a floating window
    -- The background color used hides information!
    open_fn = require('packer.util').float,
  }
}--]]})

-- When we are bootstrapping demand restarting nvim
if packer_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically sync (`PackerUpdate` and then `PackerCompile`) whenever this file is saved
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerSync',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting Options ]]
-- See: `:help vim.o` or https://neovim.io/doc/user/options.html
-- `vim.o` is for getting and setting options
-- `vim.bo` for buffer-scoped and `vim.wo` for window-scoped options

local options = {
  -- Enable break indent
  breakindent = true,
  -- Use clipboard register '+' for all yank, delete, change and put operations
  clipboard = 'unnamedplus',
  -- Set number of screen lines to use for command-line
  cmdheight = 1,
  -- Options for insert mode completion
  -- menuone: Use the popup menu also when there is only one match
  -- noselect: Do not select a match in the menu automatically
  completeopt = 'menuone,noselect',
  -- Use the appropriate number of spaces to insert a <Tab>
  expandtab = true,
  -- Use `UTF-8` as file encoding
  fileencoding = 'utf-8',
  -- Disable setting highlight on search
  hlsearch = false,
  -- Enable case insensitive searching UNLESS /C or capital in search
  ignorecase = true,
  -- Enable showing whitespace
  list = true,
  -- Define list of whitespace characters to show
  -- add `eol:\\u23ce` for carriage-return
  listchars = 'tab:\\u21e5\\u00b7,trail:·,nbsp:+,leadmultispace:·',
  -- Enable mouse mode
  mouse = 'a',
  -- Enable line numbers
  number = true,
  -- Maximum number of items to show in the popup menu
  pumheight = 10,
  -- Disable relative numbers
  relativenumber = false,
  -- Number of spaces to use for each step of (auto)indent
  shiftwidth = 2,
  -- Enable column for signs
  signcolumn = 'yes',
  -- Override `ignorecase` if the search pattern contains upper case characters
  smartcase = true,
  -- Enable smart autoindenting when starting a new line
  smartindent = true,
  -- Splitting a window will put the new window below the current one
  splitbelow = true,
  -- V-splitting a window will put the new window right of the current one
  splitright = true,
  -- Number of spaces that a <Tab> in the file counts for
  tabstop = 2,
  -- Enable 24-bit RGB color in the TUI
  termguicolors = true,
  -- Save undo history
  undofile = true,
  -- Time until swap file is written to disk
  updatetime = 250,
}

for k, v in pairs(options) do
  vim.o[k] = v
end

-- [[ Colorscheme ]]
-- Set colorscheme
vim.cmd [[ colorscheme gruvbox ]]

-- [[ Keymaps ]]
-- Modes:
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = ":"

-- Set <Space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Map <Space> to <Nop> as it’s used as leader key
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Plugins ]]

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
    component_separators = '·',
    section_separators = '',
  },
}

-- Set bufferline as tabline
-- See `:help bufferline.nvim`
require('bufferline').setup({
  options = {
    numbers = 'ordinal',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'left',
        separator = true
      }
    },
    show_buffer_icons = false,
    show_buffer_close_icons = false,
  }
})

-- Setup tree
require('nvim-tree').setup({
  open_on_setup = true,
})

-- Setup which key
require('which-key').setup()

-- Setup todo comments
require('todo-comments').setup({
  highlight = {
    before = '',
    keyword = 'bg',
    after = '',
  }
})

-- Setup Telescope
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Treesitter
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript' },
  highlight = { enable = true },
  indent = { enable = false },
})

-- Git Signs
-- See `:help gitsigns.txt`
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

-- [[ Language Server Protocol ]]

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Define mappings specific for LSP related items.
  -- Set the mode, buffer and description accordingly.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- Done:
-- Tabs/Splits (with https://github.com/akinsho/bufferline.nvim)
-- Directory Tree (https://github.com/nvim-tree/nvim-tree.lua)
-- Which Key (https://github.com/folke/which-key.nvim)
-- Telescope for fuzzy-find (https://github.com/nvim-telescope/telescope.nvim)
-- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter, https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
-- Git integration (https://github.com/tpope/vim-fugitive, https://github.com/tpope/vim-rhubarb, https://github.com/lewis6991/gitsigns.nvim, https://github.com/sindrets/diffview.nvim)
-- Commenting (https://github.com/tpope/vim-commentary)
-- JSON manipulation and pretty printing (https://github.com/tpope/vim-jdaddy)

-- TODO:
-- Mason (Portable package manager for servers)
--   Language Server Protocol (LSP): neovim/nvim-lspconfig, williamboman/mason-lspconfig.nvim
--   Debug Adapter Protocol (DAP): mfussenegger/nvim-dap
--   Linter/Formatter: jose-elias-alvarez/null-ls.nvim
-- Cmp (Autocompletion)
-- Markdown preview (with https://github.com/ellisonleao/glow.nvim)
-- A smarter `cd` command (with https://github.com/ajeetdsouza/zoxide, https://github.com/nanotee/zoxide.vim)
-- Keymaps

-- Optional:
-- Wrap selection (with: https://github.com/tpope/vim-surround)
-- Database tools (with: https://github.com/tpope/vim-dadbod)
-- Unix commands (with: https://github.com/tpope/vim-eunuch)
-- Smart on-screen jumps (with: https://github.com/ggandor/leap.nvim)
-- Auto pairs (with https://github.com/windwp/nvim-autopairs)
