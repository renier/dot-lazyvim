return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    local a = require("mason-core.async")
    require("mason-core.async.uv").shutdown = a.promisify(function(stream, callback)
      local ok = vim.uv.shutdown(stream, function(err)
        callback((err and not err:find("ENOTCONN", 1, true)) and err or nil)
      end)
      if not ok then
        callback(nil)
      end
    end, true)

    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "impl",
      "goimports-reviser",
      "delve",
      "helm-ls",
    })
  end,
}
