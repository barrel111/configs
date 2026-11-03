local quarto_status, quarto = pcall(require, "quarto")
if not quarto_status then
  return
end

quarto.setup()
vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })
