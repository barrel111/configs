local setup, conform = pcall(require, "conform")
if not setup then
  return 
end

conform.setup({
  formatter_by_ft = {
    elm = {"elm_format"},
    haskell = {"ormolu"},
    lua = {"stylua"},
    rust = {"rustfmt"},
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  }
})
