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
-- local winbargrp = vim.api.nvim_create_augroup("DynamicWinBar", { clear = true })
-- vim.api.nvim_create_autocmd(
--   { "DirChanged", "CursorMoved", "BufWinEnter", "BuffFilePost", "InsertEnter", "BufWritePost" },
--   {
--     group = winbargrp,
--     pattern = { "*.*", "*file", "*rc" },
--     callback = function(props)
--       local function get_diagnostic_label(obj)
--         local icons = {
--           error = LazyVim.config.icons.diagnostics.Error,
--           warn = LazyVim.config.icons.diagnostics.Warn,
--           info = LazyVim.config.icons.diagnostics.Info,
--           hint = LazyVim.config.icons.diagnostics.Hint,
--         }
--         local label = {}
--
--         for severity, icon in pairs(icons) do
--           local n = #vim.diagnostic.get(obj.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
--           if n > 0 then
--             table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
--           end
--         end
--         -- if #label > 0 then
--         table.insert(label, { "┊ " })
--         -- end
--         print(table.concat(label, " "))
--         return table.concat(label, " ")
--       end
--
--       if vim.bo.filetype == "neotree" or vim.bo.filetype == "" then
--         return
--       end
--       local filename = vim.fn.fnamemodify(props.file, ":.")
--       local devicons = require("nvim-web-devicons")
--       local ft_icon, _ = devicons.get_icon_color(filename)
--       local value = "%=%m "
--         .. get_diagnostic_label(props)
--         .. (ft_icon or "")
--         .. " "
--         .. (vim.bo[props.buf].modified and "⁜" or "")
--         .. filename
--       pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
--     end,
--   }
-- )

-- AutoSave buffers when leaving insert mode
-- local savegrp = vim.api.nvim_create_augroup("AutoSave", { clear = true })
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   group = savegrp,
--   pattern = { "*" },
--   callback = function(args)
--     if vim.fn.getbufvar(args.buf, "&modifiable") ~= 1 then
--       return
--     end
--     if vim.bo.filetype == "" or vim.bo.filetype == "neotree" then
--       return
--     end
--     if not vim.api.nvim_buf_get_option(args.buf, "modified") then
--       return
--     end
--     -- if contains({ "go", "lua", "python", "javascript", "typescript", "rust", "java" }, vim.bo.filetype) then
--     -- autoformat doesn't seem to be happing when we write the buffer via vim.cmd
--     -- on its own as if the events that trigger it don't fire.
--     -- vim.lsp.buf.format({ bufnr = args.buf })
--     require("conform").format({ bufnr = args.buf })
--     -- end
--     vim.cmd("silent! write")
--   end,
-- })

-- Load filetype syntax options
local ftoptsgrp = vim.api.nvim_create_augroup("LoadFiletypeOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = ftoptsgrp,
  pattern = { "*.*", "*file" },
  callback = function()
    if vim.bo.filetype == "neotree" or vim.bo.filetype == "" then
      return
    end
    vim.cmd("silent! source " .. vim.env.HOME .. "/.config/nvim/after/syntax/" .. vim.bo.filetype .. ".vim")
  end,
})
