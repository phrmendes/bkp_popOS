local now, later = require("mini.deps").now, require("mini.deps").later

require("plugins.mini")

now(function()
	require("plugins.dressing")
end)

later(function()
	require("plugins.autotag")
	require("plugins.colorizer")
	require("plugins.completion")
	require("plugins.dap")
	require("plugins.dial")
	require("plugins.executor")
	require("plugins.image")
	require("plugins.lsp")
	require("plugins.luasnip")
	require("plugins.neogen")
	require("plugins.obsidian")
	require("plugins.quarto")
	require("plugins.refactoring")
	require("plugins.toggleterm")
	require("plugins.treesitter")
	require("plugins.yanky")
	require("plugins.zen")
end)
