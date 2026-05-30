-- LSP: mason installs the server binaries locally (no sudo, lives in nvim's
-- data dir), mason-lspconfig bridges mason names -> lspconfig and auto-enables
-- each installed server via vim.lsp.enable (Neovim 0.11+ native LSP), and
-- nvim-lspconfig ships the per-server config definitions.
return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- Servers to install + enable. mason-lspconfig pulls these via mason and
    -- enables them automatically; the binaries are Node-based (ts_ls, eslint,
    -- html, cssls, jsonls) and Python (pyright, ruff).
    ensure_installed = {
      -- Node / web
      "ts_ls",   -- TypeScript & JavaScript
      "eslint",  -- ESLint diagnostics + fixes
      "html",
      "cssls",
      "jsonls",
      -- Python
      "pyright", -- types, completion, navigation
      "ruff",    -- linting + formatting (built-in language server)
      -- C# (needs the .NET SDK on PATH to analyze projects)
      "omnisharp",
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)

    -- Buffer-local keymaps once a server attaches.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
      callback = function(args)
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "References")
        map("gi", vim.lsp.buf.implementation, "Go to implementation")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>e", vim.diagnostic.open_float, "Line diagnostics")
        map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
        map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
      end,
    })
  end,
}
