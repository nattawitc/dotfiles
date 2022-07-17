local options = {
	fugitive_gitea_domains = { "git.brankas.dev" },
}

for k, v in pairs(options) do
	vim.g[k] = v
end
