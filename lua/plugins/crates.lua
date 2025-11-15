return {
  "saecki/crates.nvim",
  ft = { "toml" },
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      optional = false,
      enabled = true,
      version = false,
    },
  },
  config = function()
    require("crates").setup({
      completion = {
        cmp = {
          enabled = true,
        },
      },
    })
  end,
}
