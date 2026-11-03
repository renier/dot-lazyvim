vim.filetype.add({
  pattern = {
    -- Matches filenames like deployment.yaml.gotmpl
    ["(.*)%.yaml%.gotmpl"] = "yaml.gotmpl",

    -- Generic rule for Helm files (usually templates inside a helm chart)
    -- Matches filenames like deployment.yaml -> yaml.helm
    ["(.*)%.yaml%.helm"] = "yaml.helm",
    -- Or match standard Helm paths
    [".*/templates/.*%.yaml"] = "yaml.helm",
  },
})

-- Tell Tree-sitter which parser to use for these compound filetypes
if pcall(require, "nvim-treesitter") then
  vim.treesitter.language.register("gotmpl", "yaml.gotmpl")
  vim.treesitter.language.register("helm", "yaml.helm")
  -- Inject YAML syntax highlighting into the gotmpl text nodes via Lua
  vim.treesitter.query.set(
    "gotmpl",
    "injections",
    [[
      ((text) @injection.content
      (#set! injection.language "yaml")
      (#set! injection.combined))
    ]]
  )
  vim.treesitter.query.set(
    "helm",
    "injections",
    [[
      ((text) @injection.content
      (#set! injection.language "yaml")
      (#set! injection.combined))
    ]]
  )
end
