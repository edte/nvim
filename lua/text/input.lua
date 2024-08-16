local M = {}

M.config = function()
	------------------------------------------------------自动切英文输入法------------------------------
	-- 但是用的mac rime，故直接用rime的vim mode，不用这里配置了
	-- 切换到英文输入法
	-- function Switch_to_English_input_method()
	-- 	Current_input_method = vim.fn.system("im-select")
	-- 	if Current_input_method ~= "com.apple.keylayout.ABC\n" then
	-- 		vim.fn.system("im-select com.apple.keylayout.ABC")
	-- 	end
	-- end

	-- function Switch_to_Chinese_input_method()
	-- 	Current_input_method = vim.fn.system("im-select")
	-- 	if Current_input_method ~= "im.rime.inputmethod.Squirrel.Hans\n" then
	-- 		vim.fn.system("im-select im.rime.inputmethod.Squirrel.Hans")
	-- 	end
	-- end

	-- 进入normal模式时切换为英文输入法
	-- vim.cmd("autocmd InsertLeave * :lua Switch_to_English_input_method()")
	-- vim.cmd("autocmd InsertEnter * :lua Switch_to_Chinese_input_method()")

	vim.g.input_method = "english"

	-- return true if cur node is a comment node
	--- @return boolean
	local function is_comment_node()
		-- print(vim.bo.filetype)
		-- Check if the current buffer's filetype is 'telescopeprompt', and return false if it is
		if
			vim.bo.filetype == "TelescopePrompt"
			or vim.bo.filetype == "NeogitCommitMessage"
			or vim.bo.filetype == "dashboard"
		then
			return false
		end

		local ts = vim.treesitter

		local char_col = vim.fn.charcol(".")
		local linen = vim.fn.line(".")
		if char_col >= vim.fn.charcol("$") and char_col ~= 1 then
			char_col = vim.fn.charcol("$") - 1
		end
		local cur_node = ts.get_node({ bufnr = 0, pos = { linen - 1, char_col - 1 } })
		local loop_cnt = 0
		repeat
			if cur_node == nil then
				return false
			end
			if vim.fn.match(cur_node:type(), "comment") ~= -1 then
				return true
			end
			cur_node = cur_node:parent()
			loop_cnt = loop_cnt + 1
		until loop_cnt < 3

		-- not in comment node
		return false
	end

	function Set_rime_english()
		if vim.g.input_method == "chinese" then
			vim.cmd("ToggleRime")
			vim.g.input_method = "english"
		end
		-- print(vim.g.input_method)
	end

	function Set_rime_chinese()
		if vim.g.input_method == "english" then
			vim.cmd("ToggleRime")
			vim.g.input_method = "chinese"
		end
		-- print(vim.g.input_method)
	end

	function toggle_rime_if_comment()
		if is_comment_node() then
			Set_rime_chinese()
		end
	end

	function toggle_rime_normal()
		Set_rime_english()
	end

	function check_comment_and_toggle_rime()
		if is_comment_node() then
			Set_rime_chinese()
		else
			Set_rime_english()
		end
	end

	-- vim.cmd([[
	-- augroup rime_insert
	--   autocmd!
	--   autocmd InsertEnter * :lua toggle_rime_if_comment()
	-- augroup END
	-- ]])

	-- vim.cmd([[
	-- augroup rime_normal
	--   autocmd!
	--   autocmd InsertLeave * :lua toggle_rime_normal()
	-- augroup END
	-- ]])

	-- vim.cmd([[
	-- augroup rime_comment
	--   autocmd!
	--   autocmd InsertCharPre * :lua check_comment_and_toggle_rime()
	-- augroup END
	-- ]])
end

return M
