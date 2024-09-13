vim.cmd([[
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

	augroup _helm
		autocmd!
		autocmd FileType helm setlocal expandtab
	augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end


	function! s:DiffWithSaved()
	  let filetype=&ft
	  diffthis
	  vnew | r # | normal! 1Gdd
	  diffthis
	  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
	endfunction
	com! DiffSaved call s:DiffWithSaved()
]])

local python = vim.api.nvim_create_augroup("python", { clear = true })

local pyopts = {
	textwidth = 79,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = python,
	pattern = { "python" },
	callback = function()
		for k, v in pairs(pyopts) do
			vim.opt_local[k] = v
		end
	end,
})
