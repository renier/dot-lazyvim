local render = function(props)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
  if filename == "" then
    filename = "[No Name]"
  end
  local devicons = require("nvim-web-devicons")
  local ft_icon, ft_color = devicons.get_icon_color(filename)

  local function get_git_diff()
    local icons = {
      [1] = { name = "added", icon = " " },
      [2] = { name = "changed", icon = " " },
      [3] = { name = "removed", icon = " " },
    }
    local signs = vim.b[props.buf].gitsigns_status_dict
    local labels = {}
    if signs == nil then
      return labels
    end
    for i = 1, 3 do -- ensure this loop matches the size of the icons table
      local name = icons[i].name
      local icon = icons[i].icon
      if tonumber(signs[name]) and signs[name] > 0 then
        table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
      end
    end
    if #labels > 0 then
      table.insert(labels, { "┊ " })
    end
    return labels
  end

  local function get_diagnostic_label()
    local icons = {
      error = LazyVim.config.icons.diagnostics.Error,
      warn = LazyVim.config.icons.diagnostics.Warn,
      info = LazyVim.config.icons.diagnostics.Info,
      hint = LazyVim.config.icons.diagnostics.Hint,
    }
    local label = {}

    for severity, icon in pairs(icons) do
      local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
      if n > 0 then
        table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
      end
    end
    -- if #label > 0 then
    table.insert(label, { "┊ " })
    -- end
    return label
  end

  return {
    { get_diagnostic_label() },
    -- { get_git_diff() },
    {
      (ft_icon or "") .. " ",
      guifg = ft_color,
      guibg = "none",
    },
    {
      (vim.bo[props.buf].modified and "⁜" or "") .. filename,
      gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
    },
    -- { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
  }
end

return {
  "b0o/incline.nvim",
  name = "incline",
  enable = true,
  dependencies = { "nvim-tree/nvim-web-devicons", lazy = false },
  config = function()
    require("incline").setup({
      render = render,
      window = {
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        overlap = {
          borders = false,
          statusline = false,
          tabline = false,
          winbar = false,
        },
      },
    })
  end,
  event = "VeryLazy",
}
