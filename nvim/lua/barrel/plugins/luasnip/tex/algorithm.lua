local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local utils = require("barrel.plugins.luasnip.tex.utils")

-- The semicolon keeps triggers out of ordinary prose.
-- Expand only after indentation, outside math/comments/code.
local function text_line(line_to_cursor, matched_trigger)
  return line_begin(line_to_cursor, matched_trigger)
      and utils.in_text()
      and not utils.in_comment()
      and vim.fn["vimtex#syntax#in"]("tex\\%(Verb\\|Minted\\|Lst\\)Zone") == 0
end

local function algorithm_body(line_to_cursor, matched_trigger)
  return text_line(line_to_cursor, matched_trigger) and utils.in_env("algorithmic")
end

local function algorithm_start(line_to_cursor, matched_trigger)
  return text_line(line_to_cursor, matched_trigger)
      and not utils.in_env("algorithmic")
      and not utils.in_env("algorithm")
      and not utils.in_env("algorithm*")
end

local function auto(trigger, description, template, nodes, condition)
  return s(
    { trig = trigger, snippetType = "autosnippet", wordTrig = false, dscr = description },
    fmta(template, nodes),
    { condition = condition or algorithm_body, show_condition = function() return false end }
  )
end

-- These are typed explicitly, not offered as prose completions.
-- Tab / Shift-Tab traverse fields. Conditions and return values start in math;
-- statements and input/output fields are prose (use the existing `mm` for math).
return {
  auto(";alg", "Captioned, numbered algorithm", [[
\begin{algorithm}[H]
    \caption{<>}
    \label{alg:<>}
    \begin{algorithmic}[1]
        \Require <>
        \Ensure <>
        <>
    \end{algorithmic}
\end{algorithm}
<>
]], { i(1, "Algorithm name"), i(2, "name"), i(3, "Inputs"), i(4, "Output"), i(5), i(0) }, algorithm_start),

  auto(";st", "Algorithm statement", [[\State <>]], { i(0) }),

  auto(";for", "Algorithm for loop", [[
\For{\( <> \)}
    <>
\EndFor
<>
]], { i(1, "i = 1, \\ldots, n"), i(2), i(0) }),

  auto(";if", "Algorithm conditional", [[
\If{\( <> \)}
    <>
\EndIf
<>
]], { i(1, "condition"), i(2), i(0) }),

  auto(";while", "Algorithm while loop", [[
\While{\( <> \)}
    <>
\EndWhile
<>
]], { i(1, "condition"), i(2), i(0) }),

  auto(";ret", "Algorithm return value", [[\State \Return \( <> \)<>]], { i(1), i(0) }),

  auto(";com", "Algorithm standalone comment", [[\LComment{<>}<>]], { i(1), i(0) }),
}
