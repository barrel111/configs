local M = {}

local MATH_ENVIRONMENTS = {
  displaymath = true, eqnarray = true, equation = true, align = true,
  gather = true, multline = true, flalign = true, alignat = true,
  math = true, array = true, lp = true,
  matrix = true, pmatrix = true, bmatrix = true, Bmatrix = true,
  vmatrix = true, Vmatrix = true, cases = true, aligned = true,
  alignedat = true, gathered = true, split = true,
}
local MATH_NODES = {
  displayed_equation = true, inline_formula = true, math_environment = true,
}
local TEXT_COMMANDS = {
  ["\\text"] = true, ["\\intertext"] = true, ["\\shortintertext"] = true,
  ["\\emph"] = true, ["\\textit"] = true, ["\\textbf"] = true,
  ["\\texttt"] = true, ["\\textrm"] = true, ["\\textsc"] = true,
  ["\\textsf"] = true,
}

local function position()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  -- Autosnippets run after the typed character. At EOL, querying one byte past
  -- the line can return the surrounding environment instead of the formula.
  local col = cursor[2]
  if vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then col = col - 1 end
  return cursor[1], math.max(0, math.min(col, #line - 1))
end

local function syntax_predicate(name, ...)
  local row, col = position()
  local args = { ... }
  vim.list_extend(args, { row, col + 1 })
  local ok, value = pcall(vim.fn["vimtex#syntax#" .. name], unpack(args))
  return ok and (value == 1 or value == true)
end

local function get_node_at_cursor()
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "latex")
  if not ok or not parser then return end
  local parsed, trees = pcall(parser.parse, parser)
  if not parsed or not trees[1] then return end
  local row, col = position()
  return trees[1]:root():named_descendant_for_range(row - 1, col, row - 1, col)
end

function M.in_comment()
  local node = get_node_at_cursor()
  while node do
    if node:type() == "comment" or node:type() == "line_comment" then return true end
    node = node:parent()
  end
  return syntax_predicate("in_comment")
end

function M.in_verbatim()
  return syntax_predicate("in", "tex\\%(Verb\\|Minted\\|Lst\\)Zone")
end

function M.in_mathzone()
  if M.in_comment() or M.in_verbatim() then return false end
  local node = get_node_at_cursor()
  while node do
    local kind = node:type()
    -- The closest enclosing context wins: an inline formula inside \text is
    -- still math, while ordinary text inside a formula is not.
    if kind == "text_mode" then return false end
    if kind == "generic_command" then
      local command = node:field("command")[1] or node:child(0)
      if command and TEXT_COMMANDS[vim.treesitter.get_node_text(command, 0)] then
        return false
      end
    end
    if MATH_NODES[kind] then return true end
    if kind == "generic_environment" or kind == "math_environment" then
      local begin = node:field("begin")[1]
      local name = begin and begin:field("name")[1]
      if name and MATH_ENVIRONMENTS[vim.treesitter.get_node_text(name, 0):gsub("[{}%s*]", "")] then
        return true
      end
    end
    node = node:parent()
  end
  -- Tree-sitter may not form a math node until the closing delimiter exists.
  -- VimTeX's syntax regions also work while a formula is being typed and when
  -- the parser is unavailable. lp is registered in core/options.lua.
  return syntax_predicate("in_mathzone")
end

return M
