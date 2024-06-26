local luasnip = require("luasnip")
local d = luasnip.dynamic_node
local f = luasnip.function_node
local i = luasnip.insert_node
local s = luasnip.snippet

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local utils = require("shaleen.plugins.luasnip.tex.utils")

return {
	s(
		{ trig = "mm", snippetType = "autosnippet", wordTrig = true, regTrig = false },
		fmta("<>$ <> $", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, utils.get_visual),
		})
	),

	s(
		{ trig = "env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			}
		),
		{ condition = line_begin }
	),

	s(
		{ trig = "eq", snippetType = "autosnippet", dscr = "Expands 'eq' into an equation environment" },
		fmta(
			[[
      \begin{equation*}
          <>
      \end{equation*}
     ]],
			{ i(1) }
		),
		{ condition = line_begin }
	),

	s(
		{ trig = "al", snippetType = "autosnippet", descr = "Expands 'al' into an align environment" },
		fmta(
			[[
      \begin{align*}
          <>
      \end{align*}
      ]],
			{ i(1) }
		),
		{ condition = line_begin }
	),
}
