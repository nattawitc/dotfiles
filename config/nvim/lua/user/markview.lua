local status_ok, markview = pcall(require, "markview")
if not status_ok then
	print("markview failed to load")
end
--[[ local preset_status_ok, presets = pcall(require, "markview.presets") ]]
--[[ if not preset_status_ok then ]]
--[[ 	print("markview preset failed to load") ]]
--[[ end ]]

markview.setup({
	modes = { "n", "i", "no", "c" },
	hybrid_modes = { "i" },
})

-- enable when testing
--[[ vim.cmd("Markview enableAll") ]]
