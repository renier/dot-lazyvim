return {
  "saecki/crates.nvim",
  ft = { "toml" },
  config = function()
    require("crates").setup({
      completion = {
        cmp = { enabled = false },
        blink = { use_custom_kind = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
}
