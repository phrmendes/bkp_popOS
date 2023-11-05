local neogen = require("neogen")

neogen.setup({
	snippet_engine = "luasnip",
	enabled = true,
	languages = {
		python = {
			template = {
				annotation_convention = "numpydoc",
			},
		},
	},
})
