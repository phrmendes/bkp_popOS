local comment = require("mini.comment")
local ts_commentstring = require("ts_context_commentstring.internal")

comment.setup({
	options = {
		custom_commentstring = function()
			return ts_commentstring.calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
