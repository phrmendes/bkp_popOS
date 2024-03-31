local cmp = require("cmp")
local luasnip = require("luasnip")
local border = cmp.config.window.bordered()

require("cmp_pandoc").setup({
	filetypes = { "quarto", "markdown" },
	crossref = {
		documentation = true,
		enable_nabla = true,
	},
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-CR>"] = cmp.mapping(function(fallback)
			cmp.abort()
			fallback()
		end, { "i", "s" }),
		["<TAB>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-TAB>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			ellipsis_char = "...",
			maxwidth = 50,
			mode = "symbol",
			symbol_map = {
				otter = "🦦",
				Copilot = "",
			},
		}),
	},
	window = {
		completion = border,
		documentation = border,
	},
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline", max_item_count = 10 },
		{ name = "path" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.filetype({ "markdown", "quarto" }, {
	sources = cmp.config.sources({
		{ name = "otter" },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "cmp_pandoc" },
		{ name = "latex_symbols", option = { strategy = 2 } },
		{ name = "buffer" },
	}, {
		{ name = "buffer" },
	}),
})
