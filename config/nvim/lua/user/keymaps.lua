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
--local merge = function(t1, t2)
--	vim.tbl_deep_extend("keep", t1, t2)
--end

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

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
keymap("n", "<Up>", "gk", opts)
keymap("n", "<Down>", "gj", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Scroll with cursor at the same place on screen
keymap("n", "K", "<C-y>k", opts)
keymap("n", "J", "<C-e>j", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Act like D and C
keymap("n", "Y", "y$", opts)

-- Tab navigation
keymap("n", "<leader>tn", ":tabprevious<CR>", opts)
keymap("n", "<leader>tb", ":tabnext<CR>", opts)
keymap("n", "<leader>tp", ":BufferLinePick<CR>", opts)

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

-- Open and source vimrc
keymap("n", "<leader>rv", ":vsplit $MYVIMRC<CR>", opts)
-- keymap("n", "<leader>sv", ":luafile $MYVIMRC<CR>", opts) -- doesn't works since require() was cache

-- Toggle tool
keymap("n", "<space>", "foldclosed('.') != -1 ? 'zO' : 'zc'", merge({ expr = true }, opts))
keymap("n", "<S-space>", "zA", opts)
keymap("n", "<leader>h", "<cmd>set hlsearch!<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Tab navigation
keymap("i", "<C-S-t>", "<Esc>:tabprevious<CR>i", opts)
keymap("i", "<C-t>", "<Esc>:tabnext<CR>i", opts)

-- Visual --
-- Exit all visual mode with only 'v' key
keymap("v", "v", "mode()", merge({ expr = true }, opts))

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
--keymap("v", "<A-j>", ":m .+1<CR>==", opts)
--keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- paste text without yanking it
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
--keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Plugins --
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope --
keymap("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opts)

-- Gitsigns
keymap("n", "<leader>gn", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gb", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", opts)

-- vim-fugitive
keymap("n", "<leader>gg", "<CMD>Git<CR>", opts)

-- easymotion
local emopts = merge({ noremap = false }, opts)
keymap("n", "/", "<Plug>(easymotion-sn)", emopts)
keymap("v", "/", "<Plug>(easymotion-sn)", emopts)
keymap("o", "/", "<Plug>(easymotion-tn)", emopts)
keymap("n", "<leader>mc", "<Plug>(easymotion-overwin-f2)", emopts)
keymap("n", "<leader>mj", "<Plug>(easymotion-j)", emopts)
keymap("n", "<leader>mk", "<Plug>(easymotion-k)", emopts)
