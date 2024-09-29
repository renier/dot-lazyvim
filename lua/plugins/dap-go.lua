return {
  "leoluz/nvim-dap-go",
  opts = function(_, opts)
    opts.delve = {
      build_flags = {
        ["-ldflags"] = "-linkmode=internal",
        ["-tags"] = "integration",
      },
    }
  end,
}
