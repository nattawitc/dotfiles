require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.copilot")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.autocommands")
require("user.markdownpreview")
require("user.block")
require("user.scrollbar")
require("user.refactoring")
require("user.markview")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
