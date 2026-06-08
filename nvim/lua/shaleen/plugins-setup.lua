local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lua functions that other plugins may use
  "nvim-lua/plenary.nvim",

  -- theme
  "ellisonleao/gruvbox.nvim",

  -- convenience
  "tpope/vim-surround",

  -- icons
  "nvim-tree/nvim-web-devicons",

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("shaleen.plugins.nvim-tree")
    end,
  },

  -- status-line
  "nvim-lualine/lualine.nvim",

  -- telescope/fuzzy-finding
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },

  -- autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- lsp config
  "neovim/nvim-lspconfig",

  -- lsp integration with other plugins
  "hrsh7th/cmp-nvim-lsp",

  -- linters and formatters
  "stevearc/conform.nvim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },

  -- brackets
  "windwp/nvim-autopairs",

  -- git integration
  "lewis6991/gitsigns.nvim",

  -- vimtex
  "lervag/vimtex",

  -- typst
  {
    "chomosuke/typst-preview.nvim",
    ft = { "typst" },
    version = "1.*",
    opts = {},
  },
  { "kaarmu/typst.vim",  ft = { "typst" } },

  -- quarto
  { "jmbuhr/otter.nvim", commit = "f3a4018" },
  "quarto-dev/quarto-nvim",

  -- zotero
  {
    "jmbuhr/telescope-zotero.nvim",
    dependencies = { "kkharji/sqlite.lua" },
  },

  "jmbuhr/cmp-pandoc-references",
}, { rocks = { enabled = false } })
