local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node

local fmta = require("luasnip.extras.fmt").fmta

local utils = require("barrel.plugins.luasnip.tex.utils")

return {
  s(
    { trig = ";tt", snippetType = "autosnippet", dscr = "Expands ';tt' into '\\texttt{}'" },
    fmta("\\texttt{<>}", {
      d(1, utils.get_visual),
    }),
    { condition = utils.in_textzone }
  ),

  s(
    { trig = ";tb", snippetType = "autosnippet", dscr = "Expands ';tb' into '\\textbf{}'" },
    fmta("\\textbf{<>}", {
      d(1, utils.get_visual),
    }),
    { condition = utils.in_textzone }
  ),

  s(
    { trig = ";tii", snippetType = "autosnippet", dscr = "Expands ';tii' into '\\textit{}'" },
    fmta("\\textit{<>}", {
      d(1, utils.get_visual),
    }),
    { condition = utils.in_textzone }
  ),

  s(
    { trig = ";emp", snippetType = "autosnippet", dscr = "Expands ';emp' into '\\emph{}'" },
    fmta("\\emph{<>}", {
      d(1, utils.get_visual),
    }),
    { condition = utils.in_textzone }
  ),

  s(
    { trig = ";tsc", snippetType = "autosnippet", dscr = "Expands ';tsc' into '\\textsc{}'" },
    fmta("\\textsc{<>}", {
      d(1, utils.get_visual),
    }),
    { condition = utils.in_textzone }
  ),

  s(
    { trig = "txt", snippetType = "autosnippet", wordTrig = false, dscr = "Text inside math" },
    fmta("\\text{<>}", { d(1, utils.get_visual) }),
    { condition = utils.in_mathzone }
  ),
}
