local status_ok, block = pcall(require, "block")
if not status_ok then
	return
end

block.setup({
	colors = {
		"#2c4c3b",
		"#306844",
		"#182c25",
		"#455b55",
		"#1e453e",
	},
})
