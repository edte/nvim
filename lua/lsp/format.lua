--==========================================luvar_vim format settings===============================================================

local M = {}

function M.config()
	-- 配置 cpp 格式化
	-- https://github.com/LunarVim/LunarVim/issues/2597#issuecomment-1122731886=
	Autocmd("FileType", { pattern = { "*.cpp" }, command = "setlocal ts=4 sw=4" })
	Autocmd("FileType", { pattern = { "*.c" }, command = "setlocal ts=4 sw=4" })

	-- visual模式下缩进代码
	keymap("v", "<", "<gv")
	keymap("v", ">", ">gv")

	local null_ls = try_require("null-ls")
	if null_ls == nil then
		return
	end

	local augroup = GroupId("LspFormatting", {})

	--TODO: 这里cpp判断不格式化
	null_ls.setup({
		debug = true,
		sources = {
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
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							-- async = true,
							timeout_ms = 100,
							filter = function(client)
								return client.name ~= "clangd"
							end,
						})
					end,
				})
			end
		end,
	})
end

return M
