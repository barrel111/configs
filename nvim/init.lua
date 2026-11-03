-- must be set before netrw loads (early Vim startup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

require("barrel.plugins-setup")
require("barrel.core.options")
require("barrel.core.keymaps")
require("barrel.core.colorscheme")
require("barrel.plugins.lualine")
require("barrel.plugins.telescope")
require("barrel.plugins.nvim-cmp")
require("barrel.plugins.luasnip")
require("barrel.plugins.lsp.conform")
require("barrel.plugins.lsp.lspconfig")
require("barrel.plugins.autopairs")
require("barrel.plugins.precognition")
require("barrel.plugins.treesitter")
require("barrel.plugins.gitsigns")
require("barrel.plugins.quarto")
