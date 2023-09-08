-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

-- Set a sensible winbar text for buffers except when the filetype is undetermined
-- or when the buffer is neo-tree.
local winbargrp = vim.api.nvim_create_augroup("DynamicWinBar", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = winbargrp,
  pattern = { "*.*", "*file" },
  callback = function()
    if vim.bo.filetype == "neotree" or vim.bo.filetype == "" then
      return
    end
    vim.wo.winbar = "%=%m %f"
  end,
})

-- Always assume Edit Always if there is a swap file for the opened file.
local swapgrp = vim.api.nvim_create_augroup("SwapChoice", { clear = true })
vim.api.nvim_create_autocmd("SwapExists", {
  group = swapgrp,
  pattern = { "*" },
  callback = function()
    vim.swapchoice = "e"
  end,
})

-- AutoSave buffers when leaving insert mode
local savegrp = vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = savegrp,
  pattern = { "*" },
  callback = function(args)
    if vim.fn.getbufvar(args.buf, "&modifiable") ~= 1 then
      return
    end
    if vim.bo.filetype == "" or vim.bo.filetype == "neotree" then
      return
    end
    if not vim.api.nvim_buf_get_option(args.buf, "modified") then
      return
    end
    vim.cmd("silent! write")
  end,
})
