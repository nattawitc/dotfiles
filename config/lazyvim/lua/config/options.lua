-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local options = {
  autoread = true, -- Automatically read changed files
  backup = false, -- Don't create annoying backup files
  clipboard = { "unnamedplus", "unnamed" }, -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "preview", "noselect" }, -- Show popup menu, even if there is one entry
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = false, -- highlight the current line
  errorbells = false, -- No beeps
  --  expandtab = true,                              -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  fileformats = { "unix", "dos", "mac" }, -- Prefer Unix over Windows over OS 9 formats
  hidden = true, -- Buffer should still exist if window is closed
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true, -- Shows the match while typing
  laststatus = 2, -- Show status line: 2 = always
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- Show line numbers
  numberwidth = 4, -- set number column width to 2 {default 4}
  previewheight = 5, -- viewing documentation
  pumheight = 10, -- Completion window max size
  relativenumber = true, -- Show relative line numbers
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  scrolloff = 12, -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 20, -- Minimal number of screen columns to keep to the left and right of the cursor
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showcmd = true, -- Show me what I'm typing
  showmatch = false, -- Do not show matching brackets by flickering
  --  smartindent = true,                            -- make indenting smarter again
  splitright = true, -- Vertical windows should be split to right
  splitbelow = true, -- Horizontal windows should split to bottom
  swapfile = false, -- Don't use swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = false, -- enable persistent undo
  --  updatetime = 300,                              -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  --  guifont = "monospace:h17",                     -- the font used in graphical neovim applications
  foldmethod = "expr", --
  foldexpr = "nvim_treesitter#foldexpr()", -- use treesitter as folding method
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end
