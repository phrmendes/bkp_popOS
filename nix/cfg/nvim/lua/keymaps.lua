local buf = vim.lsp.buf
local diag = vim.diagnostic
local g = vim.g
local lsp = vim.lsp
local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local buf_keymap = vim.api.nvim_buf_set_keymap

local bufremove = require("mini.bufremove")
local dap = require("dap")
local dap_python = require("dap-python")
local dap_ui = require("dapui")
local dial = require("dial.map")
local formatters = require("conform")
local gitsigns = require("gitsigns")
local luasnip = require("luasnip")
local metals = require("metals")
local nabla = require("nabla")
local neogen = require("neogen")
local neotest = require("neotest")
local todos = require("todo-comments")
local utils = require("utils")
local wk = require("which-key")

local telescope = {
	builtin = require("telescope.builtin"),
	extensions = require("telescope").extensions,
}

-- [[ augroups ]] -------------------------------------------------------
local ft_group = augroup("UserFiletypeKeymaps", { clear = true })
local lsp_augroup = augroup("UserLspConfig", { clear = true })

-- [[ unbind keys ]] ----------------------------------------------------
local keys = { "<Space>", "<", ">" }

for _, key in ipairs(keys) do
	map({ "n", "v" }, key, "<Nop>", { noremap = true, silent = true })
end

-- [[ multi cursor ]] ---------------------------------------------------
g.multi_cursor_use_default_mapping = 0
g.VM_mouse_mappings = 1

-- [[ which-key settings ]] ---------------------------------------------
wk.setup({ window = { border = "single", position = "bottom" } })

-- [[ keymaps ]] --------------------------------------------------------
-- remap for dealing with word wrap
map("n", "k", [[v:count == 0 ? "gk" : "k"]], { expr = true, silent = true })
map("n", "j", [[v:count == 0 ? "gj" : "j"]], { expr = true, silent = true })

-- exit mode pressing "jk"
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

-- resize windows
map("n", "+", "<cmd>resize +2<cr>", { noremap = true, silent = true })
map("n", "-", "<cmd>vertical resize -2<cr>", { noremap = true, silent = true })
map("n", "=", "<cmd>vertical resize +2<cr>", { noremap = true, silent = true })
map("n", "_", "<cmd>resize -2<cr>", { noremap = true, silent = true })

-- buffers
utils.section("b", "buffers", "<leader>", "n")
map("n", "<leader>/", telescope.builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
map("n", "<S-l>", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<leader>bb", telescope.builtin.buffers, { desc = "List buffers" })
map("n", "<leader>bd", bufremove.delete, { desc = "Delete" })
map("n", "<leader>bo", "<cmd>w <bar> %bd <bar> e# <bar> bd# <cr><cr>", { desc = "Close all other buffers" })
map("n", "<leader>bw", bufremove.wipeout, { desc = "Wipeout" })

-- chatgpt
utils.section("c", "ChatGPT", "<leader>", { "n", "v" })
map({ "n", "v" }, "<leader>ca", "<cmd>ChatGPTRun add_tests<cr>", { desc = "Add tests" })
map({ "n", "v" }, "<leader>cc", "<cmd>ChatGPT<cr>", { desc = "ChatGPT" })
map({ "n", "v" }, "<leader>cd", "<cmd>ChatGPTRun docstring<cr>", { desc = "Docstring" })
map({ "n", "v" }, "<leader>ce", "<cmd>ChatGPTEditWithInstruction<cr>", { desc = "Edit with instruction" })
map({ "n", "v" }, "<leader>cf", "<cmd>ChatGPTRun fix_bugs<cr>", { desc = "Fix bugs" })
map({ "n", "v" }, "<leader>cg", "<cmd>ChatGPTRun grammar_correction<cr>", { desc = "Grammar correction" })
map({ "n", "v" }, "<leader>ck", "<cmd>ChatGPTRun keywords<cr>", { desc = "Keywords" })
map({ "n", "v" }, "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<cr>", { desc = "Code readability analysis" })
map({ "n", "v" }, "<leader>co", "<cmd>ChatGPTRun optimize_code<cr>", { desc = "Optimize code" })
map({ "n", "v" }, "<leader>cs", "<cmd>ChatGPTRun summarize<cr>", { desc = "Summarize" })
map({ "n", "v" }, "<leader>ct", "<cmd>ChatGPTRun translate<cr>", { desc = "Translate" })
map({ "n", "v" }, "<leader>cx", "<cmd>ChatGPTRun explain_code<cr>", { desc = "Explain code" })

-- DAP
map("n", "<F1>", dap.continue, { desc = "Debugger: continue" })
map("n", "<F2>", dap.step_over, { desc = "Debugger: step over" })
map("n", "<F3>", dap.step_into, { desc = "Debugger: step into" })
map("n", "<F4>", dap.step_back, { desc = "Debugger: step back" })
map("n", "<F5>", dap.step_out, { desc = "Debugger: step out" })

utils.section("d", "debugger", "<leader>", { "n", "v" })
map("v", "<leader>de", dap_ui.eval, { desc = "Evaluate" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", utils.conditional_breakpoint, { desc = "Conditional breakpoint" })
map("n", "<leader>dp", dap.pause, { desc = "Pause" })
map("n", "<leader>dq", dap.close, { desc = "Quit" })
map("n", "<leader>dt", dap_ui.toggle, { desc = "See last session result" })

utils.section("dl", "list", "<leader>", "n")
map("n", "<leader>dlv", telescope.extensions.dap.variables, { desc = "Variables" })
map("n", "<leader>dlb", telescope.extensions.dap.list_breakpoints, { desc = "Breakpoints" })

-- files
utils.section("f", "files", "<leader>", "n")
map("n", "<leader><space>", telescope.builtin.find_files, { desc = "Find files" })
map("n", "<leader>fG", telescope.builtin.git_files, { desc = "Git files" })
map("n", "<leader>fg", telescope.builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })
map("n", "<leader>fz", telescope.extensions.zoxide.list, { desc = "Zoxide" })

-- git
map("n", "[h", gitsigns.prev_hunk, { desc = "Previous hunk" })
map("n", "]h", gitsigns.next_hunk, { desc = "Next hunk" })

utils.section("g", "git", "<leader>", { "n", "v" })
map("n", "<leader>gB", telescope.builtin.git_branches, { desc = "Branches" })
map("n", "<leader>gC", "<cmd>Git commit %<cr>", { desc = "Commit (project)" })
map("n", "<leader>gG", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gL", "<cmd>Git log<cr>", { desc = "Log (project)" })
map("n", "<leader>gP", "<cmd>Git push<cr>", { desc = "Push" })
map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
map("n", "<leader>gc", "<cmd>Git commit %<cr>", { desc = "Commit (file)" })
map("n", "<leader>gd", "<cmd>Git difftool<cr>", { desc = "Diff tool" })
map("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Status" })
map("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Log (file)" })
map("n", "<leader>gm", "<cmd>Git mergetool<cr>", { desc = "Merge tool" })
map("n", "<leader>gp", "<cmd>Git pull<cr>", { desc = "Pull" })

utils.section("gb", "buffer", "<leader>", { "n", "v" })
map("n", "<leader>gbd", "<cmd>Gvdiffsplit<cr>", { desc = "Diff buffer" })
map("n", "<leader>gbr", gitsigns.reset_buffer, { desc = "Reset buffer" })
map("n", "<leader>gbs", gitsigns.stage_buffer, { desc = "Stage buffer" })

utils.section("gh", "hunk", "<leader>", { "n", "v" })
map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk" })
map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
map("v", "<leader>ghr", utils.git.reset_hunk, { desc = "Reset hunk" })
map("v", "<leader>ghs", utils.git.stage_hunk, { desc = "Stage hunk" })

-- todos
map("n", "]t", todos.jump_next, { desc = "Next todo comment" })
map("n", "[t", todos.jump_prev, { desc = "Previous todo comment" })

-- obsidian
utils.section("o", "obsidian", "<leader>", { "n", "v" })
map("n", "<leader>o<space>", "<cmd>ObsidianSearch<cr>", { desc = "Search" })
map("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Backlinks" })
map("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Diary (today)" })
map("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link under cursor" })
map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" })
map("n", "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch to another note" })

-- repl
utils.section("r", "REPL", "<leader>", "n")
map("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Open" })
map("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart" })
map("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "Focus" })
map("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide" })

-- tests
utils.section("t", "tests", "<leader>", "n")
map("n", "<leader>tt", neotest.run.run, { desc = "Run nearest test" })
map("n", "<leader>ts", neotest.run.stop, { desc = "Stop nearest test" })
map("n", "<leader>ta", neotest.run.attach, { desc = "Attach nearest test" })

map("n", "<leader>tT", function()
	neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run current file" })
map("n", "<leader>td", function()
	neotest.run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })

-- general keymaps
map("n", "<leader>-", "<C-w>s", { desc = "Split window" })
map("n", "<leader>.", telescope.builtin.commands, { desc = "Commands" })
map("n", "<leader>S", "<cmd>Copilot panel<cr>", { desc = "Copilot sugestions" })
map("n", "<leader>W", "<cmd>wq<cr>", { desc = "Save and quit" })
map("n", "<leader>Z", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
map("n", "<leader>\\", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>a", neogen.generate, { desc = "Generate annotations", noremap = true, silent = true })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer" })
map("n", "<leader>h", telescope.builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>p", "<cmd>PasteImg<cr>", { desc = "Paste image" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo tree" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>x", "<C-w>q", { desc = "Close window" })
map({ "n", "v" }, "<leader>F", formatters.format, { desc = "Format file or range" })
map({ "n", "v", "i" }, "<C-,>", telescope.builtin.symbols, { desc = "Symbols" })

-- markdown/quarto
autocmd("FileType", {
	pattern = { "quarto", "markdown" },
	group = ft_group,
	callback = function()
		map({ "n", "i" }, "<C-b>", telescope.extensions.bibtex.bibtex, { desc = "Insert reference" })
		map("n", "<C-CR>", utils.md_toggle, { desc = "Toggle check" })

		utils.section("m", "markdown", "<leader>", "n")
		map("n", "<leader>me", nabla.popup, { desc = "Equation preview popup" })
		map("n", "<leader>mp", "<Plug>MarkdownPreviewToggle", { desc = "Preview" })
		map("n", "<leader>mt", nabla.toggle_virt, { desc = "Toggle equation preview" })

		utils.section("mq", "quarto", "<leader>", "n")
		map("n", "<leader>mqp", "<cmd>QuartoPreview<cr>", { desc = "Preview" })
		map("n", "<leader>mqq", "<cmd>QuartoClosePreview<cr>", { desc = "Stop preview" })

		utils.section("z", "zotero", "<leader>", "n")
		map("n", "<leader>zc", "<Plug>ZCitationCompleteInfo", { desc = "Citation info (complete)" })
		map("n", "<leader>zi", "<Plug>ZCitationInfo", { desc = "Citation info" })
		map("n", "<leader>zo", "<Plug>ZOpenAttachment", { desc = "Open attachment" })
		map("n", "<leader>zv", "<Plug>ZViewDocument", { desc = "View exported document" })
		map("n", "<leader>zy", "<Plug>ZCitationYamlRef", { desc = "Citation info (yaml)" })
	end,
})

-- lsp
autocmd("LspAttach", {
	group = lsp_augroup,
	callback = function()
		map("n", "[d", diag.goto_prev, { desc = "LSP: previous diagnostic message" })
		map("n", "]d", diag.goto_next, { desc = "LSP: next diagnostic message" })
		map("n", "gD", buf.declaration, { desc = "LSP: go to declaration" })
		map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP: references" })
		map("n", "gd", telescope.builtin.lsp_definitions, { desc = "LSP: go to definition" })
		map("n", "gh", buf.hover, { desc = "LSP: show hover" })
		map("n", "gi", telescope.builtin.lsp_implementations, { desc = "LSP: go to implementation" })
		map("n", "gr", buf.rename, { desc = "LSP: rename" })
		map("n", "gs", buf.signature_help, { desc = "LSP: signature help" })
		map({ "n", "v" }, "ga", buf.code_action, { desc = "LSP: code actions" })

		utils.section("l", "LSP", "<leader>", { "n", "v" })
		map("n", "<leader>lD", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
		map("n", "<leader>lS", telescope.builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
		map("n", "<leader>lc", lsp.codelens.run, { desc = "Run code lens" })
		map("n", "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
		map("n", "<leader>ll", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list (Trouble)" })
		map("n", "<leader>lq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list (Trouble)" })
		map("n", "<leader>ls", telescope.builtin.lsp_document_symbols, { desc = "Document symbols" })
	end,
})

-- snippets
map({ "i", "s" }, "<C-k>", function()
	if luasnip.choice_active() then
		return luasnip.change_choice(-1)
	end
end)

map({ "i", "s" }, "<C-j>", function()
	if luasnip.choice_active() then
		return luasnip.change_choice(1)
	end
end)

-- language specific keymaps
autocmd("FileType", {
	pattern = "python",
	group = ft_group,
	callback = function()
		buf_keymap(0, "n", "<C-a>", dial.inc_normal("python"), { noremap = true })
		buf_keymap(0, "n", "<C-x>", dial.dec_normal("python"), { noremap = true })

		utils.section("dp", "python", "<leader>", { "n", "v" })
		map("n", "<leader>dpm", dap_python.test_method, { desc = "Test method" })
		map("n", "<leader>dpc", dap_python.test_class, { desc = "Test class" })
		map("v", "<leader>dps", dap_python.debug_selection, { desc = "Debug selection" })
	end,
})

autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	group = ft_group,
	callback = function()
		utils.section("lS", "scala", "<leader>", "n")
		map("n", "<leader>lSw", metals.hover_worksheet, { desc = "Worksheet" })
	end,
})

-- dial
map("n", "<C-a>", dial.inc_normal(), { noremap = true })
map("n", "<C-x>", dial.dec_normal(), { noremap = true })
map("v", "<C-a>", dial.inc_visual(), { noremap = true })
map("v", "<C-x>", dial.dec_visual(), { noremap = true })

-- mini stuff
utils.section("s", "surround", "g", { "n", "v" })
