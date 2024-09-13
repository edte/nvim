local statusline_augroup = GroupId("native_statusline", { clear = true })
local icons = require("icons")

local function getProjectName()
	local res = vim.fn.system({ "tmux", "display-message", "-p", "#W" }):gsub("%c", "")
	if res ~= "" and res ~= "failed to connect to server" and res ~= "reattach-to-user-namespace" then
		-- print("tmux")
		return res
	end

	if vim.fn.system([[git rev-parse --show-toplevel 2> /dev/null]]) == "" then
		-- print("pwd")
		return vim.fn.system("basename $(pwd)"):gsub("%c", "")
	end

	res = vim.fn.system([[git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p']]):gsub("%c", "")
	if res ~= "" then
		-- print("git remote")
		return res
	end

	-- print("git local")
	return vim.fn.system([[ TOP=$(git rev-parse --show-toplevel); echo ${TOP##*/} ]]):gsub("%c", "")
end

-- LSP clients attached to buffer

local function lsp_clients()
	local current_buf = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({ bufnr = current_buf })
	if next(clients) == nil then
		return ""
	end

	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)
	end
	return " 󰌘 " .. "[" .. table.concat(c, "|") .. "]"
end

local function get_diagnostics()
	--- @param severity integer
	--- @return integer
	local function get_lsp_diagnostics_count(severity)
		if not rawget(vim, "lsp") then
			return 0
		end

		local count = vim.diagnostic.count(0, { serverity = severity })[severity]
		if count == nil then
			return 0
		end

		return count
	end

	--- @return string
	local function diagnostics_error()
		local count = get_lsp_diagnostics_count(vim.diagnostic.severity.ERROR)
		if count > 0 then
			return string.format("%%#DiagnosticError#  %s%%*", count)
		end

		return ""
	end

	--- @return string
	local function diagnostics_warns()
		local count = get_lsp_diagnostics_count(vim.diagnostic.severity.WARN)
		if count > 0 then
			return string.format("%%#DiagnosticWarn#  %s%%*", count)
		end

		return ""
	end

	--- @return string
	local function diagnostics_hint()
		local count = get_lsp_diagnostics_count(vim.diagnostic.severity.HINT)
		if count > 0 then
			return string.format("%%#DiagnosticHint#  %s%%*", count)
		end

		return ""
	end

	--- @return string
	local function diagnostics_info()
		local count = get_lsp_diagnostics_count(vim.diagnostic.severity.INFO)
		if count > 0 then
			return string.format("%%#DiagnosticInfo#  %s%%*", count)
		end

		return ""
	end

	return diagnostics_error() .. diagnostics_warns() .. diagnostics_hint() .. diagnostics_info()
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function get_git()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("%#DiagnosticHint#  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0)
			and ("%#DiagnosticWarn#  " .. git_status.changed)
		or ""
	local removed = (git_status.removed and git_status.removed ~= 0)
			and ("%#DiagnosticError#   " .. git_status.removed)
		or ""
	local branch_name = "  " .. git_status.head

	return branch_name .. added .. changed .. removed
end

local function get_time()
	return os.date("%H:%M", os.time())
end

Autocmd({ "BufEnter" }, {
	group = statusline_augroup,
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "minifiles" or vim.bo.filetype == "alpha" then
			return
		end

		StatusLine.project_name = getProjectName()
	end,
})

Autocmd({ "VimEnter", "BufEnter", "InsertLeave", "InsertEnter" }, {
	group = statusline_augroup,
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "minifiles" or vim.bo.filetype == "alpha" then
			return
		end

		StatusLine.git = get_git()
		StatusLine.diagnostics = get_diagnostics()
		StatusLine.time = get_time()
		StatusLine.file = filename()
	end,
})

Autocmd("LspProgress", {
	group = statusline_augroup,
	desc = "Update LSP progress in statusline",
	pattern = { "begin", "report", "end" },
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		lsp_progress = {
			client = vim.lsp.get_client_by_id(args.data.client_id),
			kind = args.data.params.value.kind,
			message = args.data.params.value.message,
			percentage = args.data.params.value.percentage,
			title = args.data.params.value.title,
		}

		if lsp_progress.kind == "end" then
			lsp_progress.title = nil
			vim.defer_fn(function()
				vim.cmd.redrawstatus()
			end, 500)
		else
			vim.cmd.redrawstatus()
		end

		StatusLine.lsp_clients = lsp_clients()
	end,
})

StatusLine = {
	project_name,
	file,
	git,
	diagnostics,
	lsp_clients,
	time,
}

StatusLine.active = function()
	local statusline = {
		StatusLine.project_name or "",
		icons.ui.DividerRight,
		StatusLine.file or "",
		" %y",
		icons.ui.DividerRight,
		get_git(),
		-- StatusLine.git or "",
		"%=",
		StatusLine.diagnostics,
		"%=",
		StatusLine.lsp_clients or "",
		icons.ui.DividerLeft,
		StatusLine.time or "",
	}

	return table.concat(statusline)
end

StatusLine.inactive = function()
	return ""
end

vim.opt.statusline = "%!v:lua.StatusLine.active()"

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
	group = statusline_augroup,
	pattern = {
		"NvimTree_1",
		"NvimTree",
		"TelescopePrompt",
		"fzf",
		"lspinfo",
		"lazy",
		"netrw",
		"mason",
		"noice",
		"qf",
	},
	callback = function()
		vim.opt_local.statusline = "%!v:lua.StatusLine.inactive()"
	end,
})
