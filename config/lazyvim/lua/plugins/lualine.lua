local opts = function()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  local ok, powerline = pcall(require, "lualine.themes.powerline")
  if not ok then
    return
  end

  powerline.insert = { a = powerline.insert.a } -- don't change bg on insert mode

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = true,
    update_in_insert = false,
    always_visible = false,
    diagnostics_color = {
      error = { fg = "a70200" }, -- Changes diagnostics' error color.
    },
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
    diff_color = {
      added = { fg = "91b54a" }, -- Changes the diff's added color
      modified = { fg = "3f9cbd" }, -- Changes the diff's modified color
      removed = { fg = "d9594c" }, -- Changes the diff's removed color you
    },
  }

  local filetype = {
    "filetype",
    icons_enabled = true,
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
  }

  local location = {
    "location",
    padding = 0,
  }

  -- cool function for progress
  local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end

  local spaces = function()
    return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", {})
  end

  return {
    options = {
      icons_enabled = true,
      theme = powerline,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
    },
    sections = {
      lualine_b = { branch, diagnostics }, -- default
      lualine_x = { diff, spaces },
      lualine_y = { "encoding", filetype },
      lualine_z = { progress, location },
    },
    inactive_sections = {
      --		lualine_a = {},
      --		lualine_b = {},
      --		lualine_c = { "filename" },
      --		lualine_x = { "location" },
      --		lualine_y = {},
      --		lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return {
  "nvim-lualine/lualine.nvim",
  opts = opts,
}
