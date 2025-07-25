local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/bufferline.nvim" })
	use({ "nvim-lualine/lualine.nvim" }) -- blazing fast statusline
	use({ "akinsho/toggleterm.nvim" }) -- builtin terminal
	use({ "ahmedkhalf/project.nvim" }) -- project dir detection
	use({ "lewis6991/impatient.nvim" }) -- faster lua module loading
	-- indent blankline version 3 have breaking changes
	-- https://www.reddit.com/r/neovim/comments/16u5abl/indent_blankline_v3_is_released/
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.20.8" }) -- add ghost line for tab alignment
	use({ "goolord/alpha-nvim" }) -- first page menu
	use({ "antoinemadec/FixCursorHold.nvim" }) -- fix neovim CursorHold event https://github.com/neovim/neovim/issues/12587
	use({ "folke/which-key.nvim" }) -- add suggestion popup on keybinding
	use({ "easymotion/vim-easymotion" })
	use({ "tpope/vim-surround" })
	use({ "AndrewRadev/linediff.vim" })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({
		"OXY2DEV/markview.nvim",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
			{ "nvim-tree/nvim-web-devicons" },
		},
	})
	use({ "preservim/tagbar" })
	use({ "HampusHauffman/block.nvim" })
	use({ "petertriho/nvim-scrollbar" })
	use({ "taybart/b64.nvim" })
	use({
		"zbirenbaum/copilot.lua",
	})

	-- Colorscheme
	use({ "nanotech/jellybeans.vim" })
	use({ "lunarvim/darkplus.nvim" })

	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-cmdline" })
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine (required to make cmp works, dunno why)
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	--[[ use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer ]]
	use({ "williamboman/mason.nvim" }) -- manage lsp, dap, linter etc.
	use({ "williamboman/mason-lspconfig.nvim" }) -- bridges mason.nvim with the lspconfig plugin
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "mfussenegger/nvim-dap" }) -- Debug Adapter Protocol client

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	--	use({ "p00f/nvim-ts-rainbow",requires = {"nvim-treesitter/nvim-treesitter" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", requires = { "nvim-treesitter/nvim-treesitter" } }) -- context aware commenting

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-rhubarb" }) -- enable :GBrowse
	use({ "borissov/fugitive-gitea" })

	-- Language specific
	use({ "fatih/vim-go" }) -- go
	use({ "towolf/vim-helm" }) -- for helm filetype detection

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
