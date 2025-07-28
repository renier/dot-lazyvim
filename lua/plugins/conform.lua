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
      }
      opts.formatters.goimports = {
        prepend_args = { "-local", "code.8labs.io" },
      }
      opts.formatters.yamlfmt = {
        prepend_args = { "-conf", "/Users/rmorales/.yamlfmt" },
      }
      opts.formatters.prettier = {
        prepend_args = { "--cache" },
      }
      opts.default_format_opts = {
        timeout_ms = 2000,
        lsp_fallback = true,
      }
    end,
  },
}
