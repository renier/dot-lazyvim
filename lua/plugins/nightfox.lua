return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    version = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
    end,
  },
  {
    "savq/melange-nvim",
    lazy = false,
    version = false,
    priority = 1000,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    version = false,
    config = function()
      vim.g.sonokai_style = "shusia"
      vim.g.sonokai_cursor = "auto"
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_transparent_background = false
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 0,
        ui_contrast = "high",
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
