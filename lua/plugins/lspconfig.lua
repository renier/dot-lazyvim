local util = require("lspconfig/util")

return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gr", "<cmd>Telescope lsp_references jump_type=never<cr>" }
  end,
  opts = {
    servers = {
      gopls = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            gofumpt = false,
            analyses = {
              fieldalignment = false,
              unusedparams = false,
              unusedwrite = false,
              useany = true,
              asmdecl = false,
              cgocall = false,
              lostcancel = false,
              nilness = true,
            },
            usePlaceholders = false,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
            completionBudget = "200ms",
            ["formatting.local"] = "code.8labs.io",
          },
        },
      },
    },
  },
}
