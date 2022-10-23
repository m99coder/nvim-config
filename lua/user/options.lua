--[[
  options.lua
  See: https://neovim.io/doc/user/options.html
  See: https://neovim.io/doc/user/quickref.html#option-list
  See: https://neovim.io/doc/user/lua.html#lua-options

  Vim options can be accessed through `vim.o`, which behaves like Vimscript `:set`. Similarly, there is `vim.bo` and `vim.wo` for setting buffer-scoped and window-scoped options.
--]]

-- change directory to the file in the current window
-- boolean (default off), global
vim.o.autochdir = false

-- take indent for new line from previous line
-- boolean (default on), local to buffer
vim.o.autoindent = true

-- "dark" or "light", used for highlight colors
-- string (default "dark"), global
vim.o.background = "dark"

-- keep backup file after overwriting a file
-- boolean (default off), global
vim.o.backup = false

-- wrapped line repeats indent
-- boolean (default off), local to window
vim.o.breakindent = true

-- use the clipboard as the unnamed register
-- string (default ""), global
-- "unnamedplus": A variant of the "unnamed" flag which uses the clipboard register '+' (quoteplus) instead of register '*' for all yank, delete, change and put operations which would normally go to the unnamed register.
vim.o.clipboard = "unnamedplus"

-- number of lines to use for the command-line
-- number (default 1), global or local to tab page
vim.o.cmdheight = 1

-- height of the command-line window
-- number (default 7), global
vim.o.cmdwinheight = 7

-- options for Insert mode completion
-- string (default: "menu,preview"), global
-- "menuone": Use the popup menu also when there is only one match.
-- "noselect": Do not select a match in the menu, force the user to select one from the menu.
vim.o.completeopt = "menuone,noselect"

-- ask what to do about unsaved/read-only files
-- boolean (default off), global
vim.o.confirm = true

-- highlight the screen column of the cursor
-- boolean (default off),local to window
vim.o.cursorcolumn = false

-- highlight the screen line of the cursor
-- boolean (default off), local to window
vim.o.cursorline = true

-- settings for 'cursorline'
-- string (default: "number,line"), local to window
vim.o.cursorlineopt = "number,line"

-- write <EOL> for last line in file
-- boolean (default on), local to buffer
vim.o.endofline = true

-- windows are automatically made the same size
-- boolean (default on), global
vim.o.equalalways = false

-- use spaces when <Tab> is inserted
-- boolean (default off), local to buffer
vim.o.expandtab = true

-- file encoding for multibyte text
-- string (default: ""), local to buffer
vim.o.fileencoding = "utf-8"

-- file format used for file I/O
-- string (Unix default: "unix"), local to buffer
vim.o.fileformat = "unix"

-- make sure last line in file has <EOL>
-- boolean (default on), local to buffer
vim.o.fixendofline = true

-- minimum height of a new help window
-- number (default 20), global
vim.o.helpheight = 20

-- number of command-lines that are remembered
-- number (default: 10000), global
vim.o.history = 10000

-- highlight matches with last search pattern
-- boolean (default on), global
vim.o.hlsearch = false

-- ignore case in search patterns
-- boolean (default off), global
vim.o.ignorecase = true

-- tells when last window has status lines
-- number (default 2 = always), global
vim.o.laststatus = 2

-- wrap long lines at a blank
-- boolean (default off), local to window
vim.o.linebreak = false

-- show <Tab> and <EOL>
-- boolean (default off), local to window
vim.o.list = true

-- characters for displaying in list mode
-- string (default: "tab:> ,trail:-,nbsp:+"), global or local to window global-local
-- add `eol:\\u21b5` for <EOL>
vim.o.listchars = "tab:\\u279c\\u00b7,trail:·,nbsp:+,leadmultispace:·,space:·"

-- maximum number of items in a menu
-- number (default 25), global
vim.o.menuitems = 25

-- enable the use of mouse clicks
-- string (default "nvi"), global
-- n: Normal mode
-- v: Visual mode
-- i: Insert mode
-- c: Command-line mode
-- h: all previous modes when editing a help file
-- a: all previous modes
-- r: for hit-enter and more-prompt prompt
vim.o.mouse = "nvi"

-- keyboard focus follows the mouse
-- boolean (default off), global
vim.o.mousefocus = false

-- amount to scroll by when scrolling with a mouse
-- string (default "ver:3,hor:6"), global
vim.o.mousescroll = "ver:3,hor:6"

-- print the line number in front of each line
-- boolean (default off), local to window
vim.o.number = true

-- number of columns used for the line number
-- number (default: 4), local to window
vim.o.numberwidth = 4

-- height of the preview window
-- number (default 12), global
vim.o.previewheight = 12

-- maximum number of items to show in the popup menu
-- zero means “use available screen space”
-- number (default 0), global
vim.o.pumheight = 0

-- minimum width of the popup menu
-- number (default 15), global
vim.o.pumwidth = 15

-- show relative line number in front of each line
-- boolean (default off), local to window
vim.o.relativenumber = false

-- threshold for reporting nr. of lines changed
-- number (default 2), global
vim.o.report = 2

-- show cursor line and column in the status line
-- boolean (default on), global
vim.o.ruler = true

-- minimum nr. of lines above and below cursor
-- number (default 1), global
vim.o.scrolloff = 10

-- number of spaces to use for (auto)indent step
-- number (default 8), local to buffer
vim.o.shiftwidth = 2

-- show (partial) command in status line
-- boolean (default: on), global
vim.o.showcmd = true

-- message on status line to show current mode
-- boolean (default: on), global
vim.o.showmode = true

-- tells when the tab pages line is displayed
-- number (default 1), global
-- 0: never
-- 1: only if there are at least two tab pages
-- 2: always
vim.o.showtabline = 2

-- when and how to display the sign column
-- string (default "auto"), local to window
-- auto: only when there is a sign to display
-- no: never
-- yes: always
-- number: display signs in the 'number' column
vim.o.signcolumn = "yes"

-- no ignore case when pattern has uppercase
-- boolean (default off), global
vim.o.smartcase = true

-- smart autoindenting
-- boolean (default off), local to buffer
vim.o.smartindent = true

-- use 'shiftwidth' when inserting <Tab>
-- boolean (default on), global
vim.o.smarttab = true

-- enable spell checking
-- boolean (default off), local to window
vim.o.spell = false

-- new window from split is below the current one
-- boolean (default off), global
vim.o.splitbelow = true

-- new window is put right of the current one
-- boolean (default off), global
vim.o.splitright = true

-- sets behavior when switching to another buffer
-- string (default "uselast"), global
-- uselast: jump to the previously used window when jumping to errors with quickfix commands
vim.o.switchbuf = "uselast"

-- number of spaces that <Tab> in file uses
-- number (default 8), local to buffer
vim.o.tabstop = 2

-- enables 24-bit RGB color in the TUI
-- boolean (default off), global
vim.o.termguicolors = true

-- after this many milliseconds flush swap file
-- number	(default 4000), global
-- used for faster diagnostics
vim.o.updatetime = 250

-- save undo information in a file
-- boolean (default off), local to buffer
vim.o.undofile = false

-- give informative messages
-- number (default 0), global
vim.o.verbose = 0

-- use visual bell instead of beeping
-- boolean (default off), global
vim.o.visualbell = true

-- long lines wrap and continue on the next line
-- boolean (default on), local to window
vim.o.wrap = true

-- make a backup before overwriting a file
-- boolean (default on), global
vim.o.writebackup = false
