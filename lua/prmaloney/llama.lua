-- local function wrap_text(text, max_width)
-- 	local lines = {}
-- 	for line in text:gmatch("[^\r\n]+") do
-- 		while #line > max_width do
-- 			local wrap_pos = line:sub(1, max_width):find("%s[^%s]*$")
-- 			if not wrap_pos then
-- 				wrap_pos = max_width
-- 			end
-- 			table.insert(lines, line:sub(1, wrap_pos - 1))
-- 			line = line:sub(wrap_pos + 1)
-- 		end
-- 		table.insert(lines, line)
-- 	end
-- 	return lines
-- end
--

local function wrap_text(text, max_width)
	local lines = {}

	-- Iterate over each line of text
	for line in text:gmatch("[^\r\n]+") do
		-- Skip lines that are part of a markdown code block
		if line:sub(1, 2) == "`" or line:sub(1, 2) == "\\" then
			table.insert(lines, line)
			::continue::
		end
		while #line > max_width do
			-- Find the position to wrap the line
			local wrap_pos = line:sub(1, max_width):find("%s[^%s]*$")
			if not wrap_pos then
				wrap_pos = max_width
			end

			-- Split the line into wrapped parts
			table.insert(lines, line:sub(1, wrap_pos - 1))
			line = line:sub(wrap_pos + 1)
		end

		-- Add the remaining part of the line to lines
		table.insert(lines, line)
	end

	return lines
end


vim.api.nvim_create_user_command("Chat", function(args)
	local lines = { "" }
	if args.range > 0 then
		lines = vim.api.nvim_buf_get_lines(0, args.line1 - 1, args.line2, false)
	end

	local total_width = math.floor(vim.o.columns / 2)
	local total_height = math.floor(vim.o.lines / 2)

	local context_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(context_buf, 0, -1, false, lines)
	local context_win = vim.api.nvim_open_win(context_buf, true, {
		title = "Context",
		relative = "editor",
		row = math.floor((vim.o.lines - total_height) / 2) - 1,
		col = math.floor((vim.o.columns - total_width) / 2),
		width = math.floor(total_width / 2),
		height = total_height,
		border = "rounded",
		style = "minimal",
	})

	local result_buf = vim.api.nvim_create_buf(false, true)
	local result_win =
		vim.api.nvim_open_win(result_buf, true, {
			title = "Result",
			relative = "editor",
			row = math.floor((vim.o.lines - total_height) / 2) - 1,
			col = math.floor((vim.o.columns) / 2) + 1,
			width = math.floor(total_width / 2),
			height = total_height,
			border = "rounded",
			style = "minimal",
		})

	local prompt_bufnr = vim.api.nvim_create_buf(false, true)
	pcall(vim.api.nvim_buf_set_option, prompt_bufnr, "tabstop", 1) -- #1834
	vim.api.nvim_buf_set_option(prompt_bufnr, "buftype", "prompt")
	local prompt_win = vim.api.nvim_open_win(prompt_bufnr, true, {
		title = "Prompt",
		relative = "editor",
		row = math.floor((vim.o.lines - total_height) / 2) + total_height + 1,
		col = math.floor((vim.o.columns - total_width) / 2),
		width = math.floor(total_width) + 1,
		height = 1,
		border = "rounded",
		style = "minimal",
		footer = "<Enter>: submit, <C-c>: close",
		footer_pos = "center",
	})

	local function close_wins()
		vim.api.nvim_win_close(context_win, true)
		vim.api.nvim_win_close(result_win, true)
		vim.api.nvim_win_close(prompt_win, true)
		vim.api.nvim_buf_delete(prompt_bufnr, { force = true })
	end

	local function build_prompt()
		local prompt_input = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)
		local context = vim.api.nvim_buf_get_lines(context_buf, 0, -1, false)
		return table.concat(context, "\n") .. "\n" .. table.concat(prompt_input, "\n")
	end

	vim.keymap.set("i", "<CR>", function()
		local curl = require("plenary.curl")
		local is_thinking = false
		local accumulated_data = ""
		local thinking_text = ""

		---@param data string
		local function handle_streaming_data(data)
			if data:find("<think>") then
				is_thinking = true
			elseif data:find("</think>") then
				is_thinking = false
			elseif is_thinking then
				thinking_text = thinking_text .. data
				vim.api.nvim_buf_set_lines(result_buf, 0, -1, false, { "thinking..." })
			else
				accumulated_data = accumulated_data .. data
				vim.api.nvim_buf_set_lines(result_buf, 0, -1, false, wrap_text(accumulated_data, total_width / 2))
			end
		end

		local co = coroutine.create(function()
			curl.post("http://127.0.0.1:11434/api/generate",
				{
					body = vim.fn.json_encode({ model = "codellama", prompt = build_prompt(), stream = true }),
					stream = function(_, chunk)
						if chunk then
							vim.schedule(function()
								local partial = vim.fn.json_decode(chunk)
								if partial and partial.response then
									handle_streaming_data(partial.response)
								end
							end)
						end
					end
				})
		end)
		coroutine.resume(co)
	end, { buffer = prompt_bufnr })

	vim.keymap.set("n", "<C-c>", function()
		close_wins()
	end, { buffer = prompt_bufnr })

	vim.api.nvim_win_set_cursor(prompt_win, { 1, 0 })
	vim.cmd.startinsert()
end, { range = true })
