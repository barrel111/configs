local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = {
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	keys = {
		jump_to = "p",
		expand_or_jump = "o",
		vsplit = "s",
		split = "i",
		tabe = "t",
		tabnew = "r",
		quit = { "q", "<ESC>" },
		close_in_preview = "<ESC>",
	},
	definition = {
		edit = "<CR>",
	},
})
