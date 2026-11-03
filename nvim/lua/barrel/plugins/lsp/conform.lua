local setup, conform = pcall(require, "conform")
if not setup then
  return
end

local fmts = {
  typstyle = {
    prepend_args = { "--wrap-text=sentence", "--no-reorder-import-items" },
  },
}

fmts["tex-fmt"] = {
  append_args = { "--nowrap" },
}

conform.setup({
  formatters = fmts,
  formatters_by_ft = {
    -- elm = { "elm_format" },
    -- go = { "gofmt" },
    -- haskell = { "ormolu" },
    -- lua = { "stylua" },
    -- rust = { "rustfmt" },
    tex = { "tex-fmt" },
    ocaml = { "ocamlformat" },
    typst = { "typstyle" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local view = vim.fn.winsaveview()
    conform.format({
      bufnr = args.buf,
      timeout_ms = 500,
      -- Typstyle handles both code formatting and sentence-per-line prose.
      lsp_format = (vim.bo[args.buf].filetype == "typst") and "never" or "fallback",
    })
    vim.fn.winrestview(view)
  end,
})
