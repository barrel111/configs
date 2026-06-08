local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

nvimtree.setup({
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  view = {
    side = 'right',
  },
})

