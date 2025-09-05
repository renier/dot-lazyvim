local util = require("lspconfig/util")

return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gr", "<cmd>Telescope lsp_references jump_type=never<cr>" }
    keys[#keys + 1] = { "<leader>ss", "<cmd>Telescope lsp_document_symbols symbol_width=80<cr>" }
  end,
  opts = {
    codelens = { enabled = true },
    inlay_hints = { enabled = false },
    setup = {
      rust_analyzer = function()
        return true
      end,
    },
    servers = {
      gopls = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            buildFlags = { "-tags=integration,no_duckdb_arrow" },
            gofumpt = false,
            codelenses = {
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = false,
              tidy = true,
              upgrade_dependency = true,
              vendor = false,
            },
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
            completionBudget = "2000ms",
            ["formatting.local"] = "code.8labs.io",
          },
        },
        before_init = function(_, config)
          if vim.fn.executable("go") ~= 1 then
            return
          end

          local module = vim.fn.trim(vim.fn.system("go list -m | head -1 | cut -d '/' -f 1-2"))
          if vim.v.shell_error ~= 0 then
            return
          end
          module = module:gsub("\n", ",")

          if module ~= "^code.8labs.io" then
            config.settings.gopls["formatting.local"] = "code.8labs.io"
          else
            config.settings.gopls["formatting.local"] = module
          end
        end,
      },
      starpls = {
        cmd = { "/opt/homebrew/bin/starpls" },
        filetypes = { "starlark" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      },
    },
    yaml = {
      schemas = {
        kubernetes = "charts/**/templates/*.yaml",
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
      },
    },
  },
}
