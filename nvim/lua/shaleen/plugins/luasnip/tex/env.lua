local luasnip = require("luasnip")
local d = luasnip.dynamic_node
local i = luasnip.insert_node
local s = luasnip.snippet

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin
local utils = require("shaleen.plugins.luasnip.tex.utils")

return {
  s(
    { trig = "mm", snippetType = "autosnippet" },
    fmta("\\( <> \\)", {
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
    { trig = "dm", snippetType = "autosnippet", dscr = "Expands 'dm' into \\[...\\] display math" },
    fmta("\\[\n    <>\n\\]", { i(1) }),
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
    { trig = "pm", snippetType = "autosnippet", dscr = "Expands 'pm' into a pmatrix environment" },
    fmta(
      [[
      \begin{pmatrix}
          <>
      \end{pmatrix}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "bm", snippetType = "autosnippet", dscr = "Expands 'bm' into a bmatrix environment" },
    fmta(
      [[
      \begin{bmatrix}
          <>
      \end{bmatrix}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "ca", snippetType = "autosnippet", dscr = "Expands 'ca' into a cases environment" },
    fmta(
      [[
      \begin{cases}
          <>
      \end{cases}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "al", snippetType = "autosnippet", dscr = "Expands 'al' into an align environment" },
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
