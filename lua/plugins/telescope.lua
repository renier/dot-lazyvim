return {
  "nvim-telescope/telescope.nvim",
  init = function()
    local mappings = require("telescope.mappings")
    local actions = require("telescope.actions")
    mappings.default_mappings["i"]["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
    mappings.default_mappings["n"]["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
          previewer = false,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
          },
        }))
      end,
      desc = "Find Files",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
          previewer = false,
        }))
      end,
      desc = "Find Buffers",
    },
  },
  opts = function(_, opts)
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!**/.git/*",
      },
    })
    opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
          },
        },
      },
    })
  end,
}
