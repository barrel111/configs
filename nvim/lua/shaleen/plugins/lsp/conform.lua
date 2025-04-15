local setup, conform = pcall(require, "conform")
if not setup then
  return
end

conform.setup({
  formatter_by_ft = {
    -- elm = { "elm_format" },
    -- go = { "gofmt" },
    -- haskell = { "ormolu" },
    -- lua = { "stylua" },
    -- rust = { "rustfmt" },
    ocaml = { "ocamlformat" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  }
})
