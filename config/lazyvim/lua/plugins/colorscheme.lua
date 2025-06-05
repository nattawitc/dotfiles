return {
  -- add gruvbox
  { "lunarvim/darkplus.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darkplus",
    },
  },
}
