local orgmode = require("orgmode")
local notes = os.getenv("NOTES_DIR") or os.getenv("HOME") .. "/Documents/notes"

local pandoc_tectonic_export = function(exporter)
	local current_file = vim.api.nvim_buf_get_name(0)
	local target_file = current_file:gsub("org", "pdf")
	local command = string.format("pandoc %s -o %s --pdf-engine=tectonic", current_file, target_file)
	local on_success = function(output)
		print("PDF generated successfully!")
		vim.api.nvim_echo({ { table.concat(output, "\n") } }, true, {})
	end
	local on_error = function(err)
		print("Error generating PDF!")
		vim.api.nvim_echo({ { table.concat(err, "\n"), "ErrorMsg" } }, true, {})
	end

	return exporter(command, target_file, on_success, on_error)
end

orgmode.setup_ts_grammar()

orgmode.setup({
	calendar_week_start_day = 0,
	org_agenda_start_on_weekday = 0,
	org_archive_location = notes .. "/archive.org",
	org_default_notes_file = notes .. "/quick-notes.org",
	org_edit_src_content_indentation = 2,
	org_hide_emphasis_markers = true,
	org_log_done = "time",
	org_agenda_files = notes .. "/**/*.org",
	org_todo_keywords = { "TODO(t)", "NEXT(n)", "|", "DONE(d)", "CANCELLED(c)" },
	win_split_mode = { "float", "0.8" },
	org_capture_templates = {
		a = "Agenda",
		ao = {
			description = "One-time",
			template = "* %?\n  SCHEDULED: <%<%Y-%m-%d %A>>",
			target = notes .. "/agenda/one-time.org",
		},
		ar = {
			description = "Recurrent",
			template = "* %?\n  SCHEDULED: <%<%Y-%m-%d %A> +%^{Frequency}>",
			target = notes .. "/agenda/recurrent.org",
		},
		t = "Task",
		tn = {
			description = "Standard",
			template = "* TODO [#%^{Priority}] %?",
			target = notes .. "/tasks.org",
		},
		td = {
			description = "With deadline",
			template = "* TODO [#%^{Priority}] %?\n  DEADLINE: <%<%Y-%m-%d %A>>",
			target = notes .. "/tasks.org",
		},
		q = "Quick note",
		qn = {
			description = "Note",
			template = "** %?",
			target = notes .. "/quick-notes.org",
			headine = "Notes",
		},
		ql = {
			description = "Link",
			template = "  - %^{Link} %?",
			target = notes .. "/quick-notes.org",
			headine = "Links",
		},
	},
	org_custom_exports = {
		p = {
			label = "Export to PDF file (pandoc/tectonic)",
			action = pandoc_tectonic_export,
		},
	},
	mappings = {
		global = {
			org_agenda = "<leader>oa",
			org_capture = "<leader>oc",
		},
	},
})
