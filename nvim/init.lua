-- must be set before netrw loads (early Vim startup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require("shaleen.plugins-setup")
require("shaleen.core.options")
require("shaleen.core.keymaps")
require("shaleen.core.colorscheme")
require("shaleen.plugins.lualine")
require("shaleen.plugins.telescope")
require("shaleen.plugins.nvim-cmp")
require("shaleen.plugins.luasnip")
require("shaleen.plugins.lsp.conform")
require("shaleen.plugins.lsp.lspconfig")
require("shaleen.plugins.autopairs")
require("shaleen.plugins.treesitter")
require("shaleen.plugins.gitsigns")
require("shaleen.plugins.quarto")
