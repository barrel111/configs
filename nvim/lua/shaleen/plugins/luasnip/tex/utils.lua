-- shared functions for tex snippets
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

local utils = {}

-- When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
---@diagnostic disable-next-line: unused-local
utils.get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

-- Detect whether we are in a mathzone
utils.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

utils.in_text = function()
	return not utils.in_mathzone()
end

utils.in_comment = function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end

utils.in_env = function(name) -- generic environment detection
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- A few concrete environments---adapt as needed
utils.in_equation = function() -- equation environment detection
	return utils.in_env("equation")
end

utils.in_itemize = function() -- itemize environment detection
	return utils.in_env("itemize")
end

utils.in_tikz = function() -- TikZ picture environment detection
	return utils.in_env("tikzpicture")
end

return utils
