local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local util = require("lspconfig/util")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function(_, opts)
        opts.debug = true
        if type(opts.sources) == "table" then
          local nls = require("null-ls")
          vim.list_extend(opts.sources, {
            nls.builtins.formatting.gofmt,
            nls.builtins.formatting.goimports_reviser.with({
              generator_opts = {
                args = {
                  "-company-prefixes",
                  "code.8labs.io",
                  "$FILENAME",
                },
              },
            }),
          })
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
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      },
    },
  },
}
