-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

local contains = function(list, item)
  for _, v in ipairs(list) do
    if v == item then
      return true
    end
  end
  return false
end

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
    local filename = vim.fn.expand("%:~:.:h") .. "/" .. vim.fn.expand("%:t")
    filename = filename:gsub("^%./", "")
    vim.wo.winbar = "%=%m " .. filename
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
    if contains({ "go", "lua", "python", "javascript", "typescript", "rust", "java" }, vim.bo.filetype) then
      -- autoformat doesn't seem to be happing when we write the buffer via vim.cmd
      -- on its own as if the events that trigger it don't fire.
      vim.lsp.buf.format({ bufnr = args.buf })
    end
    vim.cmd("silent! write")
  end,
})
