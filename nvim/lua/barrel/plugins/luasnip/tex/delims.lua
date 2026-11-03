local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node

local fmta = require("luasnip.extras.fmt").fmta

local utils = require("barrel.plugins.luasnip.tex.utils")

-- Do not expand inside command or environment names, even in math.
local function math_delimiter(line_to_cursor)
  if line_to_cursor:match("\\%a*$")
      or line_to_cursor:match("\\begin%s*{[^}]*$")
      or line_to_cursor:match("\\end%s*{[^}]*$") then
    return false
  end
  return utils.in_mathzone()
end

return {
  s(
    { trig = "lp", snippetType = "autosnippet", wordTrig = true, dscr = "\\left( \\right)" },
    fmta("\\left( <> \\right)", { d(1, utils.get_visual) }),
    { condition = math_delimiter }
  ),

  s(
    { trig = "lb", snippetType = "autosnippet", wordTrig = true, dscr = "\\left[ \\right]" },
    fmta("\\left[ <> \\right]", { d(1, utils.get_visual) }),
    { condition = math_delimiter }
  ),

  s(
    { trig = "lc", snippetType = "autosnippet", wordTrig = true, dscr = "\\left\\{ \\right\\}" },
    fmta("\\left\\{ <> \\right\\}", { d(1, utils.get_visual) }),
    { condition = math_delimiter }
  ),
}
