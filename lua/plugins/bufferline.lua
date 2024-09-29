return {
  "akinsho/bufferline.nvim",
  enabled = false,
  opts = function(_, opts)
    -- opts.options.separator_style = "thin"
    opts.options.separator_style = "slant"
    opts.options.offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
      },
    }
  end,
}
