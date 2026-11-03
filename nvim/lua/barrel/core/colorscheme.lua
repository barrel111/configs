local status, _ = pcall(function()
	vim.cmd("colorscheme gruvbox")
end)

if not status then
	print("Colorscheme not found!")
	return
end
