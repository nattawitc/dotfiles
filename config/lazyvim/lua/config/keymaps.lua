-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

local merge = function(t1, t2)
  local u = {}
  for k, v in pairs(t1) do
    u[k] = v
  end
  for k, v in pairs(t2) do
    u[k] = v
  end
  return u
end

local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<leader>s", ":vs<CR>", opts)

-- Normal --
-- all leader mapping are remapped to the same in whichkey.lua to support popup suggestion
-- Visual linewise up and down by default (and use gj gk to go quicker)
-- already default for lazy
-- keymap("n", "<Up>", "gk", opts)
-- keymap("n", "<Down>", "gj", opts)
-- keymap("n", "j", "gj", opts)
-- keymap("n", "k", "gk", opts)
-- keymap("v", "<Up>", "gk", opts)
-- keymap("v", "<Down>", "gj", opts)
-- keymap("v", "j", "gj", opts)
-- keymap("v", "k", "gk", opts)

-- Scroll with cursor at the same place on screen
keymap("n", "K", "<C-y>k", opts)
keymap("n", "J", "<C-e>j", opts)

-- Better window navigation
-- already default for lazy
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Act like D and C
keymap("n", "Y", "y$", opts)

-- Resize with arrows (not work for mac)
--keymap("n", "<C-Up>", ":resize -2<CR>", opts)
--keymap("n", "<C-Down>", ":resize +2<CR>", opts)
--keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
--keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "L", ":bnext<CR>", opts)
keymap("n", "H", ":bprevious<CR>", opts)

-- Move text up and down
--keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
--keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Toggle tool
keymap("n", "<space>", "foldclosed('.') != -1 ? 'zO' : 'zc'", merge({ expr = true }, opts))
keymap("n", "<S-space>", "zA", opts)

keymap("n", "<leader>q", "<cmd>q<CR>", opts)
keymap("n", "<leader>w", "<cmd>w<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Tab navigation
keymap("n", "<leader>tb", ":tabnext<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<leader>tn", ":tabprevious<CR>", opts)
keymap("n", "<leader>tN", ":tabnew<CR>", opts)
keymap("n", "<leader>tp", ":BufferLinePick<CR>", opts)

-- Visual --
-- Exit all visual mode with only 'v' key
keymap("v", "v", "mode()", merge({ expr = true }, opts))

-- Stay in indent mode
-- already default for lazy
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- paste text without yanking it
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- already default for lazy
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
