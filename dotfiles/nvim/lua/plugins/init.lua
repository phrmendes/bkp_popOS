require("plugins.colorscheme")
require("plugins.completion")
require("plugins.copilot")
require("plugins.git")
require("plugins.lsp")
require("plugins.mini")
require("plugins.neogen")
require("plugins.repl")
require("plugins.snippets")
require("plugins.spectre")
require("plugins.tasks")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.undotree")
require("plugins.which-key")
require("plugins.zen")

if vim.fn.has("mac") == 0 then
	require("plugins.ia")
	require("plugins.obsidian")
	require("plugins.image")
	require("plugins.quarto")
end
