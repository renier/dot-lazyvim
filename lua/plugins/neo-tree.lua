return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "●", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "−", -- this can only be used in the git_status source
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "?",
          ignored = "·",
          unstaged = "",
          staged = "✔",
          conflict = "✖",
        },
      },
      container = {
        enable_character_fade = true,
      },
      indent = {
        expander_collapsed = "⟩",
        expander_expanded = "﹀",
      },
    },
    filesystem = {
      components = {
        name = function(config, node, state)
          local result = require("neo-tree.sources.common.components").name(config, node, state)
          if node:get_depth() == 1 then
            result.text = vim.fn.fnamemodify(node.path, ":t")
          end
          return result
        end,
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false,
        never_show = {
          ".git",
        },
      },
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
