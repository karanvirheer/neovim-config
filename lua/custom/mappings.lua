local M = {}

M.general = {
  -- Close the current tab with Ctrl-w
  ["<C-w>"] = { ":tabclose<CR>", desc = "Close current tab" },
}

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

M.general = {}

return M
