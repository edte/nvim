--==========================================luvar_vim format settings===============================================================

local M = {}

function M.formatConfig()
	-- 配置 cpp 格式化
	-- https://github.com/LunarVim/LunarVim/issues/2597#issuecomment-1122731886=
	vim.api.nvim_create_autocmd("FileType", { pattern = { "*.cpp" }, command = "setlocal ts=4 sw=4" })
	vim.api.nvim_create_autocmd("FileType", { pattern = { "*.c" }, command = "setlocal ts=4 sw=4" })

	-- visual模式下缩进代码
	keymap("v", "<", "<gv")
	keymap("v", ">", ">gv")

	local null_ls = try_require("null-ls")
	if null_ls == nil then
		return
	end

	local sources = {
		null_ls.builtins.formatting.sql_formatter.with({ command = { "sleek" } }),

		null_ls.builtins.formatting.goimports_reviser.with({
			command = { "goimports-reviser" },
			args = { "$FILENAME" },
			-- args = { "-rm-unused", "$FILENAME" },
		}),

		null_ls.builtins.formatting.stylua,
		-- require("none-ls.diagnostics.eslint"),
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.zsh,
		-- null_ls.builtins.formatting.beautysh,

		-- null_ls.builtins.formatting.gofumpt,
	}

	null_ls.setup({
		debug = true,
		sources = sources,
	})
end

return M
