local M = {}

-- Count navigable screen rows, excluding diagnostic/Precognition virtual lines.
local function text_height(first, last, end_vcol)
  local height = vim.api.nvim_win_text_height(0, {
    start_row = first - 1,
    end_row = last - 1,
    end_vcol = end_vcol,
  })
  return height.all - height.fill
end

function M.number()
  if vim.v.virtnum < 0 or not (vim.wo.number or vim.wo.relativenumber) then
    return ""
  end
  if not vim.wo.relativenumber then
    return vim.v.virtnum == 0 and vim.v.lnum or ""
  end

  local current = vim.fn.line(".")
  local wrapped = 0
  if vim.wo.wrap and vim.fn.foldclosed(current) == -1 then
    wrapped = text_height(current, current, vim.fn.virtcol(".")) - 1
  end

  local distance = vim.v.virtnum - wrapped
  -- virtnum starts at zero again when the top of a long line is scrolled off.
  local view = vim.fn.winsaveview()
  if vim.v.lnum == view.topline and view.skipcol > 0 then
    distance = distance + text_height(view.topline, view.topline, view.skipcol)
  end
  if vim.v.lnum > current then
    distance = distance + text_height(current, vim.v.lnum, 0)
  elseif vim.v.lnum < current then
    distance = distance - text_height(vim.v.lnum, current, 0)
  end

  -- Keep the absolute file line number beside the cursor, as with number+rnu.
  if distance == 0 and vim.wo.number then
    return current
  end
  return math.abs(distance)
end

function M.setup()
  vim.opt.statuscolumn = "%s%C%=%{v:lua.require'barrel.core.screen-lines'.number()} "
end

return M
