local g = vim.g

local nvim_tree = require("nvim-tree")

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

nvim_tree.setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "",
					arrow_open = "",
				},
			},
		},
	},
	-- disable window_picker
	actions = { open_file = { window_picker = { enable = false } } },
})
