return {
  "tpope/vim-fugitive",
  lazy = true,
  event = "BufEnter",
  cond = function()
    local handle = io.popen("git rev-parse --is-inside-work-tree")
    if handle ~= nil then
      local result = handle:read("*a")
      result = result:gsub("[\n\r]+", "")
      if result == "true" then
        return true
      else
        return false
      end
    else
      return false
    end
  end,
}
