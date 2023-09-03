return {
  "tpope/vim-fugitive",
  lazy = true,
  event = "BufEnter",
  cond = function()
    local f = io.open(".git", "r")
    if f ~= nil then
      io.close(f)
      return true
    else
      return false
    end
  end,
}
