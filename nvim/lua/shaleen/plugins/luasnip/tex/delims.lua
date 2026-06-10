local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node

local fmta = require("luasnip.extras.fmt").fmta

local utils = require("shaleen.plugins.luasnip.tex.utils")

return {
  s(
    { trig = "lp", snippetType = "autosnippet", dscr = "\\left( \\right)" },
    fmta("\\left( <> \\right)", { d(1, utils.get_visual) }),
    { condition = utils.in_mathzone }
  ),

  s(
    { trig = "lb", snippetType = "autosnippet", dscr = "\\left[ \\right]" },
    fmta("\\left[ <> \\right]", { d(1, utils.get_visual) }),
    { condition = utils.in_mathzone }
  ),

  s(
    { trig = "lc", snippetType = "autosnippet", dscr = "\\left\\{ \\right\\}" },
    fmta("\\left\\{ <> \\right\\}", { d(1, utils.get_visual) }),
    { condition = utils.in_mathzone }
  ),
}
