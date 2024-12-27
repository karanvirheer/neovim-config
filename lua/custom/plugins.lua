return {
  --  {
  --    "mfussenegger/nvim-dap",
  --  }
  -- handles LSP server for everything
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP's
        "clangd",
        "eslint-lsp",
        "json-lsp",
        "css-lsp",
        "cssmodules-language-server",
        "html-lsp",
        "lua-language-server",
        -- DAP
        "codelldb",
        -- Linters
        "eslint_d",
        -- Formatters
        "clang-format",
        "sql-formatter",
        "stylua",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "vim",
        "javascript",
        "html",
        "markdown",
        "markdown_inline",
        "lua",
        "json",
        "sql",
        "java",
        "python",
        "c",
        "cpp",
      },
    },
  },

  {
    "nvim-java/nvim-java",
    lazy = false,
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup {}
      require("lspconfig").jdtls.setup {
        on_attach = require("plugins.configs.lspconfig").on_attach,
        capabilities = require("plugins.configs.lspconfig").capabilities,
        filetypes = { "java" },
      }
    end,
  },
}
