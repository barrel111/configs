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
      require("barrel.plugins.nvim-tree")
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
    lazy = false,
    build = ":TSUpdate",
  },

  -- brackets
  "windwp/nvim-autopairs",

  -- git integration
  "lewis6991/gitsigns.nvim",

  -- vimtex
  "lervag/vimtex",

  -- texpresso
  {
    "let-def/texpresso.vim",
    config = function()
      local texpresso = require("texpresso")
      local launch = texpresso.launch
      texpresso.launch = function(args)
        -- TeXpresso reads ls-R indexes; GUI sessions may not inherit .zshrc.
        local texmf = vim.fn.expand("~/Library/texmf")
        local databases = vim.env.TEXMFDBS or ""
        if vim.fn.filereadable(texmf .. "/ls-R") == 1
          and not vim.tbl_contains(vim.split(databases, ":", { plain = true }), texmf) then
          vim.env.TEXMFDBS = texmf .. ":" .. databases
        end
        launch(args)
        -- Resolve references with additional passes when editing is idle.
        texpresso.send("rerun", true)
      end
    end,
  },

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
  "tris203/precognition.nvim",
}, { rocks = { enabled = false } })
