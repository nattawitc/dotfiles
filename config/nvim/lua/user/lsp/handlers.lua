local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local server_func = function(server, func)
	local ok, sv = pcall(require, "user.lsp.customs." .. server)
	local notfound = function()
		print(server .. " has no custom " .. func .. " function")
	end
	if ok then
		return sv[func] or notfound
	end
	return notfound
end

M.run = function()
	local fn = server_func(vim.bo.filetype, "run")
	fn()
end

M.build = function()
	local fn = server_func(vim.bo.filetype, "build")
	fn()
end

M.test = function()
	local fn = server_func(vim.bo.filetype, "test")
	fn()
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local format = function()
	local exclude = {
		"json",
	}
	for _, ft in ipairs(exclude) do
		if vim.bo.filetype == ft then
			return
		end
	end
	vim.lsp.buf.format()
end

local lspg = vim.api.nvim_create_augroup("LSP", { clear = true })

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "<Plug>custom_lsp_build", "", opts)
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<leader>dv", "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<leader>ds", "<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "<leader>dt", "<cmd>tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
	keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)

	vim.api.nvim_create_autocmd({ "BufWrite" }, { group = lspg, callback = format })

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

local is_helm = function()
	local root = vim.loop.cwd()
	local file = vim.api.nvim_buf_get_name(0)
	local file_noroot = file:gsub(root:gsub("%-", "%%-") .. "/", "")

	local dir_levels = {}
	for str in string.gmatch(file_noroot, "([^/]+)") do
		table.insert(dir_levels, str)
	end

	for _, v in ipairs(dir_levels) do
		local exist = vim.loop.fs_stat(root .. "/Chart.yaml") ~= nil
		if exist then
			return true
		end
		root = root .. "/" .. v
	end
	return false
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	if vim.bo[bufnr].filetype == "yaml" and is_helm() then
		vim.diagnostic.disable()
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
