local autocmd = vim.api.nvim_create_autocmd
local open = require("utils").open
local augroups = require("utils").augroups

autocmd("TermOpen", {
	group = augroups.term,
	pattern = { "*" },
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.api.nvim_command("startinsert")
	end,
})

autocmd("TermClose", {
	group = augroups.term,
	pattern = { "*" },
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})

autocmd("BufEnter", {
	pattern = { "*.pdf", "*.png", "*.jpg", "*.jpeg" },
	group = augroups.filetype,
	callback = function()
		local filename = vim.api.nvim_buf_get_name(0)
		filename = vim.fn.shellescape(filename)

		open(filename)

		vim.cmd.redraw()
	end,
})

autocmd("LspAttach", {
	group = augroups.lsp.attach,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client.server_capabilities.documentHighlightProvider then
			autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = augroups.lsp.highlight,
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = augroups.lsp.highlight,
				callback = vim.lsp.buf.clear_references,
			})

			autocmd("LspDetach", {
				group = augroups.lsp.detach,
				callback = function(ev)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "UserLspHighlight", buffer = ev.buf })
				end,
			})
		end
	end,
})

autocmd("FileType", {
	group = augroups.filetype,
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

autocmd({ "FileType" }, {
	group = augroups.filetype,
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})
