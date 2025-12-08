return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    init = function()
      -- comment this line if disabling transparency
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfox",
    },
  },
}
