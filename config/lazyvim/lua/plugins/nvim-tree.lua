local opts = function()
  local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  end

  return {
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    renderer = {
      root_folder_modifier = ":t",
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    on_attach = on_attach,
    view = {
      width = 30,
      --height = 30,
      side = "left",
    },
    git = {
      --ignore = false,
    },
  }
end

local customToggle = function()
  local nvim_tree_view = require("nvim-tree.view")
  local onTree = vim.bo.filetype == "NvimTree"
  local visible = nvim_tree_view.is_visible()
  if onTree or not visible then
    vim.cmd("NvimTreeToggle")
  else
    vim.cmd("NvimTreeFocus")
  end
end

vim.api.nvim_create_user_command("NvimTreeToggleCustom", customToggle, {})

return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = opts(),
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggleCustom<cr>", desc = "NvimTree Explorer" },
    },
  },
  { "nvim-tree/nvim-web-devicons" },
}
