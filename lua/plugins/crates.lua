return {
  "saecki/crates.nvim",
  ft = { "toml" },
  config = function()
    require("crates").setup({
      completion = {
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
