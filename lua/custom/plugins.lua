return {
  -- Auto-Closes Tags
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    opts = {
      enable_close = true, -- Auto-close tags
      enable_rename = true, -- Auto-rename paired tags
      enable_close_on_slash = false, -- Auto-close on `</`
      filetypes = { "html", "javascript", "typescript", "jsx", "tsx", "vue", "xml" },
    },
  },
  -- LeetCode
  {
    "kawre/leetcode.nvim",
    opts = {
      lang = "java",
      storage = {
        home = "~/dev/LeetCode/",
      },
      plugins = {
        non_standalone = true,
      },
    },
    cmd = "Leet",
  },
  -- Debug UI
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- Debugging
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings "dap"
    end,
  },
  -- handles LSP server for everything
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
      require "custom.configs.null-ls"
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
        "pyright",
        "ts_ls",
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
      highlight = {
        enable = true, -- Make sure syntax highlighting is enabled
        additional_vim_regex_highlighting = false,
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
