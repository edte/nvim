local M = {}

M.aliginConfig = function()
	-- 文本对齐，用于一些lsp格式化不了的代码
	local NS = { noremap = true, silent = true }

	-- Aligns to 1 character
	vim.keymap.set("x", "aa", function()
		try_require("align").align_to_char({
			length = 1,
		})
	end, NS)

	-- Aligns to 2 characters with previews
	vim.keymap.set("x", "ad", function()
		try_require("align").align_to_char({
			preview = true,
			length = 2,
		})
	end, NS)

	-- Aligns to a string with previews
	vim.keymap.set("x", "aw", function()
		try_require("align").align_to_string({
			preview = true,
			regex = false,
		})
	end, NS)

	-- Aligns to a Vim regex with previews
	vim.keymap.set("x", "ar", function()
		try_require("align").align_to_string({
			preview = true,
			regex = true,
		})
	end, NS)
end

return M
