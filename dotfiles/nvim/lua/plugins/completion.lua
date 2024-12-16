require("blink.cmp").setup({
	completion = {
		list = {
			selection = "manual",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							return require("mini.icons").get("lsp", ctx.kind) .. ctx.icon_gap
						end,
					},
				},
			},
		},
	},
	keymap = {
		["<c-y>"] = { "show", "show_documentation", "hide_documentation" },
		["<c-e>"] = { "hide", "fallback" },
		["<cr>"] = { "accept", "fallback" },
		["<c-l>"] = { "snippet_forward", "fallback" },
		["<c-h>"] = { "snippet_backward", "fallback" },
		["<c-p>"] = { "select_prev", "fallback" },
		["<c-n>"] = { "select_next", "fallback" },
		["<c-u>"] = { "scroll_documentation_up", "fallback" },
		["<c-d>"] = { "scroll_documentation_down", "fallback" },
	},
	sources = {
		default = function()
			local sources = { "lsp", "path", "snippets", "buffer", "dadbod", "lazydev" }

			if vim.bo.filetype == "markdown" or vim.bo.filetype == "quarto" then
				table.insert(sources, 1, "pandoc")
			end

			return sources
		end,
		signature = { enabled = true },
		providers = {
			lsp = { fallback_for = { "lazydev" } },
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			pandoc = { name = "cmp_pandoc", module = "blink.compat.source" },
		},
	},
})
