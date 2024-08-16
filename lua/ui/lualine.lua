local M = {}

M.config = function()
	local icons = require("icons")
	require("lualine").setup({
		options = {
			icons_enabled = icons.use_icons,
			theme = "auto",
			component_separators = {
				left = icons.ui.DividerRight,
				right = icons.ui.DividerLeft,
			},
			section_separators = {
				left = icons.ui.BoldDividerRight,
				right = icons.ui.BoldDividerLeft,
			},
			disabled_filetypes = { "alpha" },
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = {
				-- mode
				{
					function()
						return " " .. icons.ui.Target .. " "
					end,
					padding = { left = 0, right = 0 },
					color = {},
					cond = nil,
				},
			},
			lualine_b = {
				"tmux-status",
				"fileline",
			},
			lualine_c = {
				"branch",
				"diff",
			},
			lualine_x = {
				-- diagnostics
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = icons.diagnostics.BoldError .. " ",
						warn = icons.diagnostics.BoldWarning .. " ",
						info = icons.diagnostics.BoldInformation .. " ",
						hint = icons.diagnostics.BoldHint .. " ",
					},
					-- cond = conditions.hide_in_width,
				},
				{
					"lsp-status",
					color = { gui = "bold" },
					cond = function()
						return vim.o.columns > 100
					end,
				},
				-- filetype
				{
					"filetype",
					cond = nil,
					padding = { left = 1, right = 1 },
				},
			},
			lualine_y = {},
			lualine_z = { "time" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

return M
