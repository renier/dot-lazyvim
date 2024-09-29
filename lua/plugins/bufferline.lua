return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
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
