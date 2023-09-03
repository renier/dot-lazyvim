return {
  "ruifm/gitlinker.nvim",
  event = "BufEnter",
  cond = function()
    local f = io.open(".git", "r")
    if f ~= nil then
      io.close()
      return true
    else
      return false
    end
  end,
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({
      opts = {
        add_current_line_on_normal_mode = true,
        action_callback = require("gitlinker.actions").copy_to_clipboard,
        print_url = true,
      },
      callbacks = {
        ["github.com"] = require("gitlinker.hosts").get_github_type_url,
        ["github.ibm.com"] = require("gitlinker.hosts").get_github_type_url,
        ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        ["code.8labs.io"] = require("gitlinker.hosts").get_gitlab_type_url,
      },
      mappings = "<leader>gl",
    })
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap
    keymap("v", "gl", '<cmd>lua require"gitlinker".get_buf_range_url("v")<CR>', opts)
  end,
}
