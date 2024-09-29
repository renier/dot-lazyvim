local devicons = require("nvim-web-devicons")
local render = function(props)
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  if filename == "" then
    filename = "[No Name]"
  end
  local ft_icon, ft_color = devicons.get_icon_color(filename)

  local function get_git_diff()
    local icons = {
      [1] = { name = "added", icon = " " },
      [2] = { name = "removed", icon = " " },
      [3] = { name = "changed", icon = " " },
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

  return {
    { get_git_diff() },
    { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
    { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
    -- { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
  }
end

return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      render = render,
      window = {
        margin = {
          horizontal = 0,
          vertical = 0,
        },
      },
    })
  end,
  event = "VeryLazy",
}
