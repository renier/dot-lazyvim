return {
  "ruifm/gitlinker.nvim",
  cond = function()
    local handle = io.popen("git rev-parse --is-inside-work-tree")
    if handle ~= nil then
      local output = handle:read("*a")
      local result = output:gsub("[\n\r]", "")
      handle:close()
      if result == "true" then
        return true
      else
        return false
      end
    else
      return false
    end
  end,
  keys = {
    {
      "gl",
      '<cmd>lua require"gitlinker".get_buf_range_url("v", {}, {})<CR>',
      mode = "v",
      desc = "Get repo link",
    },
    {
      "<leader>gl",
      '<cmd>lua require"gitlinker".get_buf_range_url("n", {}, {silent=true})<CR>',
      mode = "n",
      desc = "Get repo link",
    },
  },
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
  end,
}
