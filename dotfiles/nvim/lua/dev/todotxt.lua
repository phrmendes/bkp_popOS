--- @module 'todotxt'
local M = {}
local config = {}

--- Reads the lines from a file.
--- @param filepath string
--- @return string[]
local read_lines = function(filepath)
	return vim.fn.readfile(filepath)
end

--- Writes the lines to a file.
--- @param filepath string
--- @param lines table
--- @return nil
local write_lines = function(filepath, lines)
	vim.fn.writefile(lines, filepath)
end

--- Updates the buffer if it is open.
--- @param filepath string
--- @param lines string[]
--- @return nil
local update_buffer_if_open = function(filepath, lines)
	local current_buf = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(current_buf)

	if bufname == filepath then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	end
end

--- Sorts the tasks in the open buffer by a given function.
--- @param sort_func function
--- @return nil
local sort_tasks_by = function(sort_func)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	table.sort(lines, sort_func)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

--- Toggles the todo state of the current line in a todo.txt file.
--- If the line starts with "x YYYY-MM-DD ", it removes it to mark as not done.
--- Otherwise, it adds "x YYYY-MM-DD " at the beginning to mark as done.
--- @return nil
M.toggle_todo_state = function()
	local node = vim.treesitter.get_node()

	if not node then
		return
	end

	local start_row, _ = node:range()
	local line = vim.fn.getline(start_row + 1)
	local pattern = "^x %d%d%d%d%-%d%d%-%d%d "

	if line:match(pattern) then
		line = line:gsub(pattern, "")
	else
		local date = os.date("%Y-%m-%d")
		line = "x " .. date .. " " .. line
	end

	vim.fn.setline(start_row + 1, line)
end

--- Opens the todo.txt file in a new split.
--- @return nil
M.open_todo_file = function()
	vim.cmd("split " .. config.todotxt)
end

--- Sorts the tasks in the open buffer by priority.
--- @return nil
M.sort_tasks_by_priority = function()
	sort_tasks_by(function(a, b)
		local priority_a = a:match("^%((%a)%)") or "Z"
		local priority_b = b:match("^%((%a)%)") or "Z"
		return priority_a < priority_b
	end)
end

--- Sorts the tasks in the open buffer by date.
--- @return nil
M.sort_tasks = function()
	sort_tasks_by(function(a, b)
		local date_a = a:match("^x (%d%d%d%d%-%d%d%-%d%d)") or a:match("^(%d%d%d%d%-%d%d%-%d%d)")
		local date_b = b:match("^x (%d%d%d%d%-%d%d%-%d%d)") or b:match("^(%d%d%d%d%-%d%d%-%d%d)")
		if date_a and date_b then
			return date_a > date_b
		elseif date_a then
			return false
		elseif date_b then
			return true
		else
			return a > b
		end
	end)
end

--- Sorts the tasks in the open buffer by project.
--- @return nil
M.sort_tasks_by_project = function()
	sort_tasks_by(function(a, b)
		local project_a = a:match("%+%w+") or ""
		local project_b = b:match("%+%w+") or ""
		return project_a < project_b
	end)
end

--- Sorts the tasks in the open buffer by context.
--- @return nil
M.sort_tasks_by_context = function()
	sort_tasks_by(function(a, b)
		local context_a = a:match("@%w+") or ""
		local context_b = b:match("@%w+") or ""
		return context_a < context_b
	end)
end

--- Sorts the tasks in the open buffer by due date.
M.sort_tasks_by_due_date = function()
	sort_tasks_by(function(a, b)
		local due_date_a = a:match("due:(%d%d%d%d%-%d%d%-%d%d)")
		local due_date_b = b:match("due:(%d%d%d%d%-%d%d%-%d%d)")
		if due_date_a and due_date_b then
			return due_date_a < due_date_b
		elseif due_date_a then
			return true
		elseif due_date_b then
			return false
		else
			return a < b
		end
	end)
end

--- Cycles the priority of the current task between A, B, C, and no priority.
--- @return nil
M.cycle_priority = function()
	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	local start_row, _ = node:range()
	local line = vim.fn.getline(start_row + 1)

	local current_priority = line:match("^%((%a)%)")
	local new_priority

	if current_priority == "A" then
		new_priority = "(B) "
	elseif current_priority == "B" then
		new_priority = "(C) "
	elseif current_priority == "C" then
		new_priority = ""
	else
		new_priority = "(A)"
	end

	if current_priority then
		line = line:gsub("^%(%a%)%s*", new_priority)
	else
		line = new_priority .. " " .. line
	end

	vim.fn.setline(start_row + 1, line)
end

--- Captures a new todo entry with the current date.
--- @return nil
M.capture_todo = function()
	vim.ui.input({ prompt = "New Todo: " }, function(input)
		if input then
			local date = os.date("%Y-%m-%d")
			local new_todo = date .. " " .. input
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname == config.todotxt then
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				table.insert(lines, new_todo)
				vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			else
				local lines = read_lines(config.todotxt)
				table.insert(lines, new_todo)
				write_lines(config.todotxt, lines)
			end
		end
	end)
end

--- Moves all done tasks from the todo.txt file to the done.txt file.
--- @return nil
M.move_done_tasks = function()
	local todo_lines = read_lines(config.todotxt)
	local done_lines = read_lines(config.donetxt)
	local remaining_todo_lines = {}

	for _, line in ipairs(todo_lines) do
		if line:match("^x %d%d%d%d%-%d%d%-%d%d ") then
			table.insert(done_lines, line)
		else
			table.insert(remaining_todo_lines, line)
		end
	end

	write_lines(config.todotxt, remaining_todo_lines)
	write_lines(config.donetxt, done_lines)

	update_buffer_if_open(config.todotxt, remaining_todo_lines)
end

M.setup = function(opts)
	opts = opts or {}
	config.todotxt = opts.todotxt or vim.env.HOME .. "/Documents/notes/todo.txt"
	config.donetxt = opts.donetxt or vim.env.HOME .. "/Documents/notes/done.txt"
end

return M
