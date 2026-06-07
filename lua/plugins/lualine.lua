return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local function neotree_root()
      local path
      local ok, manager = pcall(require, "neo-tree.sources.manager")
      if ok then
        local state = manager.get_state("filesystem")
        path = state and state.path
      end
      path = path or vim.uv.cwd()
      return "󱉭 " .. vim.fn.fnamemodify(path, ":t")
    end

    opts.extensions = opts.extensions or {}
    -- Drop LazyVim's built-in "neo-tree" extension; it shows the full cwd path.
    for i = #opts.extensions, 1, -1 do
      if opts.extensions[i] == "neo-tree" then
        table.remove(opts.extensions, i)
      end
    end
    local neotree_ext = {
      filetypes = { "neo-tree" },
      sections = {
        lualine_a = { "mode" },
        lualine_c = { neotree_root },
        lualine_z = { "location" },
      },
    }
    neotree_ext.inactive_sections = {
      lualine_c = { neotree_root },
    }
    table.insert(opts.extensions, neotree_ext)
  end,
}
