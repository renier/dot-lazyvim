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
      }
      opts.formatters.goimports = {
        prepend_args = { "-local", "code.8labs.io" },
      }
      opts.default_format_opts = {
        timeout_ms = 750,
        lsp_fallback = true,
      }
    end,
  },
}
