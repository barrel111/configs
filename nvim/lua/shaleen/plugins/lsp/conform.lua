local setup, conform = pcall(require, "conform")
if not setup then
  return
end

conform.setup({
  formatters = {
    typst_sembr = {
      command = vim.fn.expand("~/scripts/typst-sembr.sh"),
      stdin = true,
    },
  },
  formatters_by_ft = {
    -- elm = { "elm_format" },
    -- go = { "gofmt" },
    -- haskell = { "ormolu" },
    -- lua = { "stylua" },
    -- rust = { "rustfmt" },
    ocaml = { "ocamlformat" },
    typst = { "typst_sembr" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local view = vim.fn.winsaveview()
    conform.format({
      bufnr = args.buf,
      timeout_ms = 500,
      lsp_format = (vim.bo[args.buf].filetype == "typst") and "first" or "fallback",
    })
    vim.fn.winrestview(view)
  end,
})
