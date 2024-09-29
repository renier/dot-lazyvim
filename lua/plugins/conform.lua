return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = { lua = { "stylua" }, go = { "goimports" } }
    opts.formatters.goimports = {
      prepend_args = { "-local", "code.8labs.io" },
    }
    opts.format = {
      timeout_ms = 750,
      lsp_fallback = false,
    }
  end,
}
