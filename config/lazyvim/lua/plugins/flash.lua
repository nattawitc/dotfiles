return {
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x" }, false },
      { "S", mode = { "n", "x" }, false },
      {
        "?",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "o", "x" },
        desc = "Flash Treesitter",
      },
    },
  },
}
