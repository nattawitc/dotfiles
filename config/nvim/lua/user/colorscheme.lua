--vim.cmd [[
--try
--  colorscheme darkplus
--catch /^Vim\%((\a\+)\)\=:E185/
--  colorscheme default
--  set background=dark
--endtry
--]]

--local colorscheme = "jellybeans"
local colorscheme = "darkplus"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

-- for projector
--let g:lucius_style="light"
--colorscheme lucius
--set background=light
--colorscheme PaperColor
