local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    -- "cssls",
    -- "elmls",
    -- "gopls",
    -- "hls",
    -- "html",
    -- "julials",
    -- "lua_ls",
    -- "rust_analyzer",
    "texlab",
  },
})
