local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

local action_status, actions = pcall(require, "telescope.actions")
if not action_status then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

telescope.load_extension("fzf")
