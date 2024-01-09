local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local util = require("lspconfig/util")

return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gr", "<cmd>Telescope lsp_references jump_type=never<cr>" }
  end,
  dependencies = {
    {
      "nvimtools/none-ls.nvim",
      opts = function(_, opts)
        opts.debug = true
        if type(opts.sources) == "table" then
          local nls = require("null-ls")
          -- LazyVim adds gofumpt and goimports_reviser by default to the sources.
          -- I remove these foramtters from the sources here, so that I can add only the formatters
          -- I want with the options I want.
          local new_sources = {}
          for _, formatter in ipairs(opts.sources) do
            if formatter ~= nls.builtins.formatting.gofumpt and formatter ~= nls.builtins.formatting.goimports then
              table.insert(new_sources, formatter)
            end
          end
          table.insert(
            new_sources,
            nls.builtins.formatting.goimports.with({
              args = {},
              extra_args = {
                "-local",
                "code.8labs.io",
                "$FILENAME",
              },
              to_stdin = false,
            })
          )
          opts.sources = new_sources
        end

        opts.on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end
      end,
    },
  },
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
          },
        },
      },
    },
  },
}
