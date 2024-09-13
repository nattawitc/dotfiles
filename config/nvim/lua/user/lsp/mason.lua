local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local mconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mconfig_ok then
	return
end

local servers = {
	"bashls",
	"cssls",
	"eslint",
	"gopls",
	"golangci_lint_ls",
	"html",
	"jsonls",
	"pyright",
	-- new python lsp
	--[[ "ruff_lsp", ]]
	"lua_ls",
	"ts_ls",
	"yamlls",
	"helm_ls",
	"clangd",
}

--[[ setup must follow this order ]]
mason.setup()
mason_lspconfig.setup({
	ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end

	lspconfig[server].setup(opts)
end
