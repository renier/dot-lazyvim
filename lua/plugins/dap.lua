return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    opts = function(_, opts)
      opts.delve = {
        build_flags = "-tags=integration",
        -- build_flags = "-ldflags=-linkmode=internal",
      }
      opts.tests = { verbose = true }
    end,
  },
}
