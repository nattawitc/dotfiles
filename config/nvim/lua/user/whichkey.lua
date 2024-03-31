local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
	["b"] = { '<cmd>lua require("user.lsp.handlers").build()<CR>', "Build" },
	["r"] = { '<cmd>lua require("user.lsp.handlers").run()<CR>', "Run" },
	["T"] = { '<cmd>lua require("user.lsp.handlers").test()<CR>', "Test" },
	["e"] = { "<cmd>NvimTreeToggleCustom<cr>", "Explorer" },
	["m"] = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown preview" },
	["w"] = { "<cmd>w<CR>", "Save" },
	["q"] = { "<cmd>q<CR>", "Quit" },
	["h"] = { "<cmd>set hlsearch!<CR>", "Toggle highlight" },
	d = {
		name = "Definition",
		v = { "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", "On vertical split" },
		s = { "<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", "On horizontal split" },
		t = { "<cmd>tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>", "On new tab" },
	},
	f = {
		name = "Search",
		b = { "<cmd>Telescope buffers<CR>", "Buffers" },
		B = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
		f = { "<cmd>Telescope find_files hidden=true<CR>", "Files" },
		g = { "<cmd>Telescope live_grep<CR>", "Grep" },
		h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
		M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
		p = { "<cmd>Telescope projects<CR>", "Projects" },
		F = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
		R = { "<cmd>Telescope registers<CR>", "Registers" },
		k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
		C = { "<cmd>Telescope commands<CR>", "Commands" },
		r = { "<cmd>Telescope resume<CR>", "Resumes" },
	},
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	g = {
		name = "Git",
		-- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		g = { "<cmd>Git<CR>", "fugitive" },
		n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
		b = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
		l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
		p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
		d = { "<cmd>Gitsigns diffthis<CR>", "Diff" },
		s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
		u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
		i = { "<cmd>Mason<cr>", "Installer Info" },
		n = {
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
			"Next Diagnostic",
		},
		b = {
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
	},
	t = {
		name = "Tabs",
		N = { ":tabnew<CR>", "New" },
		n = { ":tabprevious<CR>", "Next" },
		b = { ":tabnext<CR>", "Previous" },
		p = { ":BufferLinePick<CR>", "Select tab" },
		c = { ":tabclose<CR>", "Close" },
		t = {
			name = "Terminal",
			n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
			u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
			t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
			p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
			f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
			h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
			v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		},
	},
}

local opts_remap = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = false, -- disable noremap to use remap plugin's mapping
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings_remap = {
	m = {
		name = "Easy motion",
		c = { "<Plug>(easymotion-overwin-f2)", "2 charactors" },
		j = { "<Plug>(easymotion-j)", "line down" },
		k = { "<Plug>(easymotion-k)", "line up" },
	},
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappings_remap, opts_remap)
which_key.register(vmappings, vopts)
