return {
  "tpope/vim-fugitive",
  lazy = true,
  event = "BufEnter",
  cond = function()
    local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
    if handle ~= nil then
      local result = handle:read("*a")
      handle:close()
      result = result:gsub("[\n\r]+", "")
      return result == "true"
    end
    return false
  end,
}
