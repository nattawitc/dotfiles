local opts = function()
  local actions = require("telescope.actions")
  return {
    defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      file_ignore_patterns = { ".git/", "node_modules", "vendor" },

      mappings = {
        i = {
          ["<Down>"] = actions.cycle_history_next,
          ["<Up>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      find_files = {
        no_ignore = true,
        no_ignore_parent = true,
      },
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  }
end
return {
  "nvim-telescope/telescope.nvim",
  opts = opts,
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fB", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
    { "<leader>fC", "<cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", desc = "Files" },
    { "<leader>fF", "<cmd>Telescope oldfiles<CR>", desc = "Open Recent File" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    { "<leader>fM", "<cmd>Telescope man_pages<CR>", desc = "Man Pages" },
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
    { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "Resumes" },
    { "<leader>fR", "<cmd>Telescope registers<CR>", desc = "Registers" },
  },
}
