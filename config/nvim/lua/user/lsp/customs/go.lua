local M = {}

M.run = function()
	vim.cmd(":GoRun<CR>")
end

M.build = function()
	local f = vim.api.nvim_buf_get_name(0)
	if string.find(f, "test.go") then
		vim.cmd(":GoTestCompile<CR>")
	elseif string.find(f, ".go") then
		vim.cmd(":GoBuild<CR>")
	else
		print("gobuild unknown file type " .. f)
	end
end

M.test = function()
	vim.cmd(":GoTest<CR>")
end

return M

--let l:file = expand('%')
--if l:file =~# '^\f\+_test\.go$'
--  call go#test#Test(0, 1)
--elseif l:file =~# '^\f\+\.go$'
--  call go#cmd#Build(0)
--endif
