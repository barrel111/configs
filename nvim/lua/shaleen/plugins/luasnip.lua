local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- lazy load local snippets
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/shaleen/plugins/luasnip/" })

-- lazy load friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

luasnip.config.set_config({ -- Setting LuaSnip config

	-- Enable autotriggered snippets
	enable_autosnippets = true,

	-- Use Tab to trigger visual selection
	store_selection_keys = "<Tab>",

	-- Update repeated nodes as it is being typed
	update_events = "TextChanged,TextChangedI",
})
