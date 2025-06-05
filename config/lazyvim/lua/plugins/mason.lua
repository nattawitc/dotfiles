local mason_tool_name = function(tool)
  local replace = {
    ruff_fix = "ruff",
    ruff_format = "ruff",
    ruff_organize_imports = "ruff",
  }
  if replace[tool] then
    return replace[tool]
  else
    return tool
  end
end

return {
  { "mason-org/mason.nvim", version = "^1.0.0" },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "golangci_lint_ls",
        "html",
        "jsonls",
        "pyright",
        "lua_ls",
        "ts_ls",
        "yamlls",
        "helm_ls",
        "clangd",
      },
    },
    keys = {
      { "<leader>l", group = "LSP" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>lb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", desc = "Prev Diagnostic" },
      { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
      { "<leader>li", "<cmd>Mason<cr>", desc = "Installer Info" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
      { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", desc = "Next Diagnostic" },
      { "<leader>lq", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature help" },
      { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>dv", "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", desc = "Open definition on vertical split" },
      {
        "<leader>ds",
        "<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>",
        desc = "Open definition on horizontal split",
      },
      { "<leader>dt", "<cmd>tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>", desc = "Open definition on new tab" },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to references" },

      -- keymap(bufnr, "n", "<Plug>custom_lsp_build", "", opts)
      -- keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
      -- keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
      -- keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- virtual_text = true, -- disable virtual text
        -- signs = {
        --   active = {
        --     { name = "DiagnosticSignError", text = "" },
        --     { name = "DiagnosticSignWarn", text = "" },
        --     { name = "DiagnosticSignHint", text = "" },
        --     { name = "DiagnosticSignInfo", text = "" },
        --   },
        -- },
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          -- border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
          source = true,
          header = "",
          prefix = "",
        },
      },
      servers = {
        yamlls = {
          on_attach = function(client, bufnr)
            vim.defer_fn(function()
              vim.lsp.buf_detach_client(bufnr, client.id)
              print("yamlls detached from helm file")
            end, 10) -- detach after 10ms
          end,
        },
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              yamlls = {
                config = {},
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black", "flake8" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim
        .iter(require("conform").list_all_formatters())
        :map(function(v)
          return mason_tool_name(v.name)
        end)
        :filter(function(v)
          -- filter out tools not in Mason
          return require("mason-registry").has_package(v)
        end)
        :totable()
    end,
    dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
  },
}
