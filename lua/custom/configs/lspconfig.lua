local configs = require "plugins.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- List of LSP servers
local servers = {
  "eslint",
  "volar",
  "html",
  "cssls",
  "cssmodules_ls",
  "jsonls",
  "pyright",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- TypeScript/JavaScript LSP (Auto-Imports)
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    -- Disable formatting in tsserver (use null-ls/prettier instead)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- ✅ Disable code actions provider in ts_ls
    -- client.server_capabilities.codeActionProvider = false

    -- Call the default on_attach function
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    tsserver = {
      suggest = {
        autoImports = true, -- ✅ Enable auto-imports
        completeFunctionCalls = true, -- ✅ Suggest full function calls
      },
      inlayHints = { includeInlayParameterNameHints = "all" }, -- Optional: Inlay hints
    },
    javascript = {
      suggest = {
        autoImports = true,
        completeFunctionCalls = true,
      },
    },
  },
}

-- Clangd LSP Configuration
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- Import On Save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- ✅ Apply only "source.fixAll" actions (e.g., ESLint auto-fixes)
    vim.lsp.buf.code_action {
      context = {
        only = { "source.fixAll" }, -- ⚡ Only apply fixable actions, not refactors
        diagnostics = {},
      },
      apply = true, -- ✅ Automatically apply fixes without showing a popup
    }
  end,
})

-- Link to the list of LSPs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
