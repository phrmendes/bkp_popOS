local now, later = require("mini.deps").now, require("mini.deps").later

require("plugins.mini")

now(function()
	require("plugins.dadbod")
	require("plugins.dressing")
	require("plugins.obsidian")
	require("plugins.yazi")
end)

later(function()
	require("plugins.completion")
	require("plugins.dap")
	require("plugins.highlight-colors")
	require("plugins.image")
	require("plugins.lazydev")
	require("plugins.lsp")
	require("plugins.luasnip")
	require("plugins.neogen")
	require("plugins.quickfix")
	require("plugins.slime")
	require("plugins.treesitter")
end)
