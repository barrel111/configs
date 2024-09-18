local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet

local fmta = require("luasnip.extras.fmt").fmta

local in_mathzone = require("shaleen.plugins.luasnip.tex.utils").in_mathzone

return {
  s(
    { trig = "(", snippetType = "autosnippet", dscr = "Expands '(' into '\\left(\\right)'" },
    fmta("\\left( <> \\right", {
      i(1),
    }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "[", snippetType = "autosnippet", dscr = "Expands '[' into '\\left[\\right]'" },
    fmta("\\left[ <> \\right", {
      i(1),
    }),
    { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
  ),

  s(
    { trig = "\\{", snippetType = "autosnippet", dscr = "Expands '\\{' into '\\left{\\right}'" },
    fmta("\\left\\{ <> \\right\\", {
      i(1),
    }),
    { condition = in_mathzone } -- `condition` option passed in the snippet `opts` table
  ),
}
