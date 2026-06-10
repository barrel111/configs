local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local in_mathzone = require("shaleen.plugins.luasnip.tex.utils").in_mathzone

local function g(trig, text)
  return s({ trig = trig, snippetType = "autosnippet" }, { t(text) }, { condition = in_mathzone })
end

return {
  g(";a", "\\alpha"),
  g(";b", "\\beta"),
  g(";g", "\\gamma"),
  g(";d", "\\delta"),
  g(";D", "\\Delta"),
  g(";e", "\\epsilon"),
  g(";z", "\\zeta"),
  g(";h", "\\eta"),
  g(";0", "\\theta"),
  g(";T", "\\Theta"),
  g(";i", "\\iota"),
  g(";k", "\\kappa"),
  g(";l", "\\lambda"),
  g(";L", "\\Lambda"),
  g(";m", "\\mu"),
  g(";n", "\\nu"),
  g(";x", "\\xi"),
  g(";X", "\\Xi"),
  g(";o", "\\omega"),
  g(";O", "\\Omega"),
  g(";p", "\\pi"),
  g(";P", "\\Pi"),
  g(";r", "\\rho"),
  g(";s", "\\sigma"),
  g(";S", "\\Sigma"),
  g(";t", "\\tau"),
  g(";u", "\\upsilon"),
  g(";U", "\\Upsilon"),
  g(";f", "\\phi"),
  g(";F", "\\Phi"),
  g(";y", "\\psi"),
  g(";Y", "\\Psi"),
}
