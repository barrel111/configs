local keymap = vim.keymap
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- make sure that space+<key> doesn't
-- move cursor
keymap.set("n", " ", "<Nop>")

-- general keymaps
-- keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>hh", ":nohl<CR>")
-- keymap.set("n", "x", "_x")

keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

keymap.set("n", "<leader>bb", "<C-^><CR>")
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- plugin keymaps
-- vim maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<Cr>")

-- telescope
-- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
-- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
-- find string under cursor in current working directory
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
-- list open buffers in current neovim instance
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
-- list available help tags
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- refresh snippets
keymap.set(
  "n",
  "<leader>L",
  '<cmd>lua require("luasnip.loaders.from_lua").load'
  .. '({paths = "~/.config/nvim/lua/shallen/plugins/luasnip/"})<CR>'
)

-- vimtex
keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>")
