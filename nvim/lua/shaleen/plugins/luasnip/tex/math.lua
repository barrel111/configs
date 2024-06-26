local ls = require("luasnip")
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet

local fmta = require("luasnip.extras.fmt").fmta

local utils = require("shaleen.plugins.luasnip.tex.utils")

return {
	s(
		{ trig = "([^%a])ff", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>\frac{<>}{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		})
	),

	s(
		{ trig = "__", snippetType = "autosnippet", dscr = "Expands '__' into '_{}'" },
		fmta("_{<>}", {
			i(1),
		})
		-- { condition = utils.in_mathzone } -- `condition` option passed in the snippet `opts` table
	),
}
