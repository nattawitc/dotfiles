-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  opts = {
    preview = {
      modes = { "n", "i", "no", "c" },
      hybrid_modes = { "i" },
    },
  },
}
