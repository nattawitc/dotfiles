return {
  {
    "saghen/blink.cmp",
    -- dependencies = {
    --   {
    --     "giuxtaposition/blink-cmp-copilot",
    --   },
    -- },
    opts = {
      completion = {
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label" },
              { "source_name" },
            },
          },
        },
        list = {
          selection = {
            preselect = false,
          },
        },
      },
      keymap = {
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      -- sources = {
      --   default = { "copilot" },
      --   providers = {
      --     copilot = {
      --       name = "copilot",
      --       module = "blink-cmp-copilot",
      --       score_offset = 100,
      --       async = true,
      --     },
      --   },
      -- },
    },
  },
}
