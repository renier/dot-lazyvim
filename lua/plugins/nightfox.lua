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
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "soft"
      vim.g.everforest_transparent_background = true
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    version = false,
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "morhetz/gruvbox",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_transparent_bg = true
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
