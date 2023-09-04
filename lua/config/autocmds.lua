-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

local grp = vim.api.nvim_create_augroup("DynamicWinBar", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = grp,
  pattern = { "*.*", "*file" },
  callback = function()
    if vim.bo.filetype == "neotree" or vim.bo.filetype == "" then
      return
    end
    vim.wo.winbar = "%=%m %f"
  end,
})
