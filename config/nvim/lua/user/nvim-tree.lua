local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("nvim_tree failed to load")
	--[[ return ]]
end

local view_status_ok, nvim_tree_view = pcall(require, "nvim-tree.view")
if not view_status_ok then
	print("nvim_tree.view failed to load")
	--[[ return ]]
end

local api_ok, api = pcall(require, "nvim-tree.api")
if not api_ok then
	print("nvim_tree.api failed to load")
	--[[ return ]]
end

local function on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

nvim_tree.setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	on_attach = on_attach,
	view = {
		width = 30,
		--height = 30,
		side = "left",
	},
	git = {
		--ignore = false,
	},
})

local customToggle = function()
	local onTree = vim.bo.filetype == "NvimTree"
	local visible = nvim_tree_view.is_visible()
	if onTree or not visible then
		vim.cmd("NvimTreeToggle")
	else
		vim.cmd("NvimTreeFocus")
	end
end

vim.api.nvim_create_user_command("NvimTreeToggleCustom", customToggle, {})
