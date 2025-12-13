return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        graphql = { "prettier" },
        json = { "jq" },
        yaml = { "yamlfmt" },
        terraform = { "terraform_fmt" },
        rust = { "rustfmt" },
        proto = { "buf" },
        python = { "ruff" },
      }
      opts.formatters.goimports = {
        prepend_args = { "-local", "code.8labs.io" },
      }
      opts.formatters.yamlfmt = {
        prepend_args = { "-conf", os.getenv("HOME") .. "/.yamlfmt" },
      }
      opts.formatters.prettier = {
        prepend_args = { "--cache" },
      }
      opts.formatters.ruff = {
        command = "uv",
        prepend_args = { "tool", "run", "ruff" },
      }
      opts.default_format_opts = {
        timeout_ms = 5000,
        lsp_fallback = true,
      }
    end,
  },
}
