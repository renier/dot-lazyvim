-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { remap = false, silent = true, desc = "Resume" }
)
-- gitlab keybindings
-- local gitlab = require("gitlab")
-- vim.keymap.set("n", "<leader>gbr", gitlab.review, { desc = "Gitlab Review" })
-- vim.keymap.set("n", "<leader>gbm", gitlab.summary, { desc = "Gitlab Open MR" })
-- vim.keymap.set("n", "<leader>gba", gitlab.approve, { desc = "Gitlab Approve" })
-- vim.keymap.set("n", "<leader>gbA", gitlab.revoke, { desc = "Gitlab Revoke Approval" })
-- vim.keymap.set("n", "<leader>gbc", gitlab.create_comment, { desc = "Gitlab Comment" })
-- vim.keymap.set("v", "<leader>gbc", gitlab.create_multiline_comment, { desc = "Gitlab Comment Multiline" })
-- vim.keymap.set("v", "<leader>gbs", gitlab.create_comment_suggestion, { desc = "Gitlab Comment Suggestion" })
-- vim.keymap.set(
--   "n",
--   "<leader>gbm",
--   gitlab.move_to_discussion_tree_from_diagnostic,
--   { desc = "Gitlab Move To Discussion" }
-- )
-- vim.keymap.set("n", "<leader>gbn", gitlab.create_note, { desc = "Gitlab Note" })
-- vim.keymap.set("n", "<leader>gbd", gitlab.toggle_discussions, { desc = "Gitlab Toggle Discussion" })
-- vim.keymap.set("n", "<leader>gbb", gitlab.add_assignee, { desc = "Gitlab Assignee Add" })
-- vim.keymap.set("n", "<leader>gbB", gitlab.delete_assignee, { desc = "Gitlab Assignee Remove" })
-- vim.keymap.set("n", "<leader>gbx", gitlab.add_reviewer, { desc = "Gitlab Reviewer Add" })
-- vim.keymap.set("n", "<leader>gbX", gitlab.delete_reviewer, { desc = "Gitlab Reviewer Remove" })
-- vim.keymap.set("n", "<leader>gbp", gitlab.pipeline, { desc = "Gitlab Pipeline" })
-- vim.keymap.set("n", "<leader>gbo", gitlab.open_in_browser, { desc = "Gitlab Open In Browser" })
