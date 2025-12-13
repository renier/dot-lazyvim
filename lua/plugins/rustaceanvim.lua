return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = ""
    if codelldb.get_install_path then
      extension_path = vim.fs.joinpath(codelldb:get_install_path(), "extension")
    else
      extension_path = vim.fs.joinpath(vim.fn.expand("$MASON"), "packages", codelldb.name, "extension")
    end
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    local cfg = require("rustaceanvim.config")
    vim.g.rustaceanvim = {
      server = {
        cmd = function()
          return { os.getenv("HOME") .. "/.cargo/bin/rust-analyzer" }
        end,
      },
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
}
