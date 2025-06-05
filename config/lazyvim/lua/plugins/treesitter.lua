return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "go",
      "goctl",
      "gomod",
      "gosum",
      "gotmpl",
      "helm",
      "html",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    }, -- one of "all" or a list of languages
    ignore_install = {
      "phpdoc", -- doesn't work with apple silicon
    }, -- List of parsers to ignore installing
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "css" } },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
  },
}
