return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))
      end,
      desc = "Find Files",
    },
  },
}
