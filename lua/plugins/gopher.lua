return {
  "olexsmir/gopher.nvim",
  ft = "go",
  opts = { timeout = 3000 },
  build = function()
    vim.cmd.GoInstallDeps()
  end,
}
