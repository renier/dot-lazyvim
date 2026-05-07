return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local function find_root(fname, markers)
      return vim.fs.root(fname, markers)
    end

    local function chart_root(fname)
      return find_root(fname, { "Chart.yaml" })
    end

    opts.codelens = { enabled = true }
    opts.inlay_hints = { enabled = false }
    opts.setup = opts.setup or {}
    opts.setup.rust_analyzer = function()
      return true
    end
    opts.servers = opts.servers or {}
    opts.servers["*"] = opts.servers["*"] or {}
    opts.servers["*"].keys = opts.servers["*"].keys or {}
    opts.servers["*"].keys[#opts.servers["*"].keys + 1] = {
      "gr",
      "<cmd>Telescope lsp_references jump_type=never<cr>",
      desc = "References",
      nowait = true,
      has = "references",
    }
    opts.servers["*"].keys[#opts.servers["*"].keys + 1] = {
      "<leader>ss",
      "<cmd>Telescope lsp_document_symbols symbol_width=80<cr>",
      desc = "Document Symbols",
      has = "documentSymbol",
    }
    opts.servers.gopls = {
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
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

        if not module:match("^code%.8labs%.io") then
          config.settings.gopls["formatting.local"] = "code.8labs.io"
        else
          config.settings.gopls["formatting.local"] = module
        end
      end,
    }
    if vim.fn.executable("/opt/homebrew/bin/starpls") == 1 then
      opts.servers.starpls = {
        cmd = { "/opt/homebrew/bin/starpls" },
        filetypes = { "starlark" },
        root_markers = { "go.work", "go.mod", ".git" },
      }
    end
    opts.servers.helm_ls = {
      filetypes = { "helm", "yaml", "yaml.helm-values" },
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = chart_root(fname)
        if root then
          on_dir(root)
        end
      end,
      single_file_support = false,
      settings = {
        ["helm-ls"] = {
          yamlls = {
            path = "yaml-language-server",
          },
        },
      },
    }
    opts.servers.yamlls = {
      filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if chart_root(fname) then
          return
        end
        on_dir(find_root(fname, { ".git" }) or vim.fs.dirname(fname))
      end,
      single_file_support = false,
      settings = {
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
  end,
}
