local treesitter = require("nvim-treesitter")
treesitter.setup({})

local function attach(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then return end
  local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
  if not lang or not pcall(vim.treesitter.start, buf, lang) then return end

  if lang == "latex" then
    -- Tree-sitter disables regex syntax when it starts. VimTeX's context
    -- detection needs it, including unfinished formulas and custom math envs.
    -- Keep VimTeX's LaTeX indentation as well.
    vim.bo[buf].syntax = "tex"
  elseif vim.treesitter.query.get(lang, "indents") then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  callback = function(args) attach(args.buf) end,
})

-- install() skips installed parsers. Attach open buffers when a first-time
-- asynchronous installation finishes, without requiring the file to reopen.
treesitter.install({ "latex", "lua", "vim", "yaml" }):await(function(err)
  if err then
    vim.schedule(function() vim.notify(tostring(err), vim.log.levels.ERROR) end)
    return
  end
  vim.schedule(function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do attach(buf) end
  end)
end)
