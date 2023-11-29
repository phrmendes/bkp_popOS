local conform = require("conform")

conform.setup({
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

conform.formatters.tex = {
	command = "latexindent.pl",
	args = { "-" },
	stdin = true,
}

conform.formatters_by_ft = {
	json = { "prettier" },
	lua = { "stylua" },
	markdown = { "prettier" },
	nix = { "alejandra" },
	python = { "ruff" },
	sh = { "shellharden" },
	terraform = { "terraform_fmt" },
	toml = { "taplo" },
	yaml = { "prettier" },
	go = { "gofumpt", "golines", "goimports-reviser" },
}
