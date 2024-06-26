local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local utils = require("shaleen.plugins.luasnip.tex.utils")

return {
	s(
		{ trig = "tt", snippetType = "autosnippet", dscr = "Expands 'tt' into '\texttt{}'" },
		fmta("\\texttt{<>}", {
			d(1, utils.get_visual),
		})
	),

	s(
		{ trig = "tb", snippetType = "autosnippet", dscr = "Expands 'tb' into '\textbf{}'" },
		fmta("\\textbf{<>}", {
			d(1, utils.get_visual),
		})
	),

	s(
		{ trig = "tii", snippetType = "autosnippet", dscr = "Expands 'tit' into '\\textit{}'" },
		fmta("\\textit{<>}", {
			d(1, utils.get_visual),
		})
	),

	s(
		{
			trig = "([^.])txt",
			snippetType = "autosnippet",
			dscr = "Expands 'txt' into '\\text{}'",
			regTrig = true,
			wordTrig = false,
		},
		fmta("\\text{<>}", {
			d(1, utils.get_visual),
		})
	),
}
