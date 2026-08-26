-- Copies a pasteable link to the current line into the clipboard.
vim.api.nvim_create_user_command("MakeLink", function()
	local function has_prefix(str, pfx)
		return str:sub(1, #pfx) == pfx
	end
	local function trim_prefix(str, pfx)
		if has_prefix(str, pfx) then
			return str:sub(#pfx + 1)
		end
		return str
	end
	local function trim(s)
		return s:match("^%s*(.-)%s*$")
	end
	local function output(cmd)
		local completion = vim.system(cmd):wait()
		if completion.code ~= 0 then
			error("command exited with code " .. completion.code .. ": " .. table.concat(cmd, " "))
		end
		return trim(completion.stdout)
	end

	local current_buf_cursor = vim.api.nvim_win_get_cursor(0)
	local line_number = current_buf_cursor[1]
	local full_path = vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0))
	local dir = vim.fs.dirname(full_path)
	local repo_path = output({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
	local remote_url = output({ "git", "-C", dir, "remote", "get-url", "origin" })
	local main_branches = output({ "git", "-C", dir, "branch", "--list", "main", "master" })
	local main_branch = trim_prefix(main_branches, "* ")
	-- @{u} is shorthand for the upstream tracking branch.
	local rev = output({ "git", "-C", dir, "rev-parse", "@{u}" })

	local rel_path = trim_prefix(full_path, repo_path .. "/")
	-- \v for "very magic", i.e. PCRE
	local github_url_pattern = "\\v(git\\@github\\.com:|https://github\\.com/)([^/]*)/([^.]+)\\.git"
	local matches = vim.fn.matchlist(remote_url, github_url_pattern)
	local user = matches[3]
	local repo = matches[4]

	local link = "https://github.com/"
		.. user
		.. "/"
		.. repo
		.. "/blob/"
		.. rev
		.. "/"
		.. rel_path
		.. "#L"
		.. line_number
	vim.fn.setreg("+", link)
	print(link .. " copied to clipboard")
end, {})
