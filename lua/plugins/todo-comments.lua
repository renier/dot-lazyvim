return {
  "todo-comments.nvim",
  opts = {
    highlight = {
      pattern = [[.*//\s*<(KEYWORDS)]],
    },
    search = {
      pattern = [[//\s*\b(KEYWORDS)]],
    },
  },
}
