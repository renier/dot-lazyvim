return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
      -- comment this line if disabling transparency
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
    init = function()
      -- comment this line if disabling transparency
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
    },
  },
}
