local opt = vim.opt

-- line numbers should be relative
-- with current line at cursor
opt.relativenumber = true
opt.number = true

-- tabs should be 2 spaces +
-- autoindentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping should be true
opt.wrap = true
opt.lbr = true
require("barrel.core.screen-lines").setup()

-- case insensitive search for lcase
-- case sensitive search for ucase
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- normal backspace behavior
opt.backspace = "indent,eol,start"

-- use system clipboard for ease
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- hyphenated is one word
opt.iskeyword:append("-")

-- latex setup
vim.g.tex_flavor = "latex"
-- The custom optimization environment contains math without explicit delimiters.
vim.g.vimtex_syntax_custom_envs = { { name = "lp", math = true } }
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = vim.fn.expand("~/scripts/sioyek-synctex.sh")

-- clean aux files when leaving a tex buffer
vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventQuit",
  callback = function()
    vim.call("vimtex#compiler#clean", 0)
  end,
})

-- suppress dumb quickfix & warnings
vim.g.vimtex_quickfix_ignore_filters = {
  "Underfull",
  "Overfull",
  "Empty bibliography"
}
