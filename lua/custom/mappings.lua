local M = {}

-- DAP Debugging Mapping
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
  },
}

-- LSP Mappings
M.lsp = {
  plugin = true,
  n = {
    ["<leader>ai"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Auto-Import Missing Modules" },
  },
}

M.general = {
  i = {
    ["jj"] = { "<ESC>", "Escape insert mode" },
  },
}

return M
