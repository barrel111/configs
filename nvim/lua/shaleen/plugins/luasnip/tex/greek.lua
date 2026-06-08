local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  -- alpha
  s({ trig = ";a", snippetType = "autosnippet" }, { t("\\alpha") }),

  -- beta
  s({ trig = ";b", snippetType = "autosnippet" }, { t("\\beta") }),

  -- gamma
  s({ trig = ";g", snippetType = "autosnippet" }, { t("\\gamma") }),

  -- delta / Delta
  s({ trig = ";d", snippetType = "autosnippet" }, { t("\\delta") }),
  s({ trig = ";D", snippetType = "autosnippet" }, { t("\\Delta") }),

  -- epsilon
  s({ trig = ";e", snippetType = "autosnippet" }, { t("\\epsilon") }),

  -- zeta
  s({ trig = ";z", snippetType = "autosnippet" }, { t("\\zeta") }),

  -- eta
  s({ trig = ";h", snippetType = "autosnippet" }, { t("\\eta") }),

  -- theta / Theta  (;0 = zero, looks like theta; ;T repurposed from invalid \Tau)
  s({ trig = ";0", snippetType = "autosnippet" }, { t("\\theta") }),
  s({ trig = ";T", snippetType = "autosnippet" }, { t("\\Theta") }),

  -- iota
  s({ trig = ";i", snippetType = "autosnippet" }, { t("\\iota") }),

  -- kappa
  s({ trig = ";k", snippetType = "autosnippet" }, { t("\\kappa") }),

  -- lambda / Lambda
  s({ trig = ";l", snippetType = "autosnippet" }, { t("\\lambda") }),
  s({ trig = ";L", snippetType = "autosnippet" }, { t("\\Lambda") }),

  -- mu
  s({ trig = ";m", snippetType = "autosnippet" }, { t("\\mu") }),

  -- nu
  s({ trig = ";n", snippetType = "autosnippet" }, { t("\\nu") }),

  -- xi / Xi
  s({ trig = ";x", snippetType = "autosnippet" }, { t("\\xi") }),
  s({ trig = ";X", snippetType = "autosnippet" }, { t("\\Xi") }),

  -- omega / Omega  (omicron has no LaTeX command — it's just 'o')
  s({ trig = ";o", snippetType = "autosnippet" }, { t("\\omega") }),
  s({ trig = ";O", snippetType = "autosnippet" }, { t("\\Omega") }),

  -- pi / Pi
  s({ trig = ";p", snippetType = "autosnippet" }, { t("\\pi") }),
  s({ trig = ";P", snippetType = "autosnippet" }, { t("\\Pi") }),

  -- rho
  s({ trig = ";r", snippetType = "autosnippet" }, { t("\\rho") }),

  -- sigma / Sigma
  s({ trig = ";s", snippetType = "autosnippet" }, { t("\\sigma") }),
  s({ trig = ";S", snippetType = "autosnippet" }, { t("\\Sigma") }),

  -- tau
  s({ trig = ";t", snippetType = "autosnippet" }, { t("\\tau") }),

  -- upsilon / Upsilon
  s({ trig = ";u", snippetType = "autosnippet" }, { t("\\upsilon") }),
  s({ trig = ";U", snippetType = "autosnippet" }, { t("\\Upsilon") }),

  -- phi / Phi
  s({ trig = ";f", snippetType = "autosnippet" }, { t("\\phi") }),
  s({ trig = ";F", snippetType = "autosnippet" }, { t("\\Phi") }),

  -- psi / Psi
  s({ trig = ";y", snippetType = "autosnippet" }, { t("\\psi") }),
  s({ trig = ";Y", snippetType = "autosnippet" }, { t("\\Psi") }),
}
