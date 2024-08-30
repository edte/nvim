local M = {}

M.list = {

	-- {
	--   "morhetz/gruvbox",
	--   config = function()
	--     vim.cmd([[
	-- "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
	-- "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
	-- "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
	-- if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
	--   if (has("nvim"))
	--     "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	--     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	--   endif
	--   "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	--   "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	--   " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	--   if (has("termguicolors"))
	--     set termguicolors
	--   endif
	-- endif
	--       ]])
	--
	--     vim.cmd([[colorscheme gruvbox]])
	--   end,
	-- },

	-- {
	--   "joshdick/onedark.vim",
	--   config = function()
	--     vim.cmd([[colorscheme onedark]])
	--   end,
	-- },

	{
		"catppuccin/nvim",
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	-- {
	--   "rebelot/kanagawa.nvim",
	--   config = function()
	--     vim.cmd([[colorscheme kanagawa]])
	--   end,
	-- },

	-- todo: 这里优化目录
	-- Status Line
	-- 状态栏
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			try_require("ui.lualine").config()
		end,
		event = "VimEnter",
		dependencies = {
			{
				"edte/lualine-ext",
				event = "VimEnter",
			},
		},
	},

	-- 符号树状视图,按 S
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "S", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			outline_window = {
				auto_close = true,
				auto_jump = true,
				show_numbers = false,
				width = 35,
				wrap = true,
			},
			outline_items = {
				show_symbol_lineno = true,
				show_symbol_details = false,
			},
		},
	},

	-- wilder.nvim 插件，用于命令行补全，和 noice.nvim 冲突
	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter", -- 懒加载：首次进入cmdline时载入
		config = try_require("ui.wilder").wilderFunc,
	},

	-- buffer 管理文件与目录树的结合
	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			options = {
				use_as_default_explorer = false,
			},
			-- Customization of explorer windows
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = false,
				-- Width of focused window
				width_focus = 200,
				-- Width of non-focused window
				width_nofocus = 100,
			},
		},
		keys = {
			{
				"<space>e",
				function()
					local mf = try_require("mini.files")
					if not mf.close() then
						mf.open(vim.api.nvim_buf_get_name(0))
						mf.reveal_cwd()
					end
				end,
			},
		},
		config = function()
			-- nvim-tree
			-- vim.g.loaded_netrw = 1
			-- vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			vim.g.loaded_netrw = false -- or 1
			vim.g.loaded_netrwPlugin = false -- or 1
		end,
	},

	-- alpha 是 Neovim 的快速且完全可编程的欢迎程序。
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- {"ibhagwan/fzf-lua",  cmd="FzfLua", lazy=true,}
		},
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("ui.dashboard").config()
		end,
	},

	-- barbar.nvim 是一个选项卡插件
	{
		"romgrk/barbar.nvim",
		ft = { "lua", "go", "cpp", "h" },
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			vim.opt.termguicolors = true
			-- 删除buffer

			keymap("n", "<<", ":BufferMovePrevious<cr>")
			keymap("n", ">>", ":BufferMoveNext<cr>")

			-- -- 移动左右 buffer
			keymap("n", "gn", ":BufferNext<CR>")
			keymap("n", "gp", ":BufferPrevious<CR>")
		end,
		opts = {
			auto_hide = 0,
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},

	-- Neovim 的缩进指南
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = function()
			require("ibl").setup()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},

	-- 这个 Neovim 插件为 Neovim 提供交替语法突出显示（“彩虹括号”），由 Tree-sitter 提供支持。目标是拥有一个可破解的插件，允许全局和每个文件类型进行不同的查询和策略配置。用户可以通过自己的配置覆盖和扩展内置默认值。
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		config = function()
			-- vim.g.rainbow_delimiters = { log = { level = vim.log.levels.DEBUG } }
			local rainbow_delimiters = require("rainbow-delimiters")
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			})
		end,
	},

	-- Whichkey
	{
		"folke/which-key.nvim",
		config = function()
			require("ui.whichkey")
		end,
		cmd = "WhichKey",
		event = "VeryLazy",
		dependencies = {
			{ "echasnovski/mini.icons", version = false },
			{
				"numToStr/Comment.nvim",
				config = function() end,
				event = "User FileOpened",
			},
		},
	},

	-- Neovim 的装饰滚动条
	{
		"lewis6991/satellite.nvim",
		config = function()
			require("satellite").setup({
				handlers = {
					marks = {
						enable = false,
					},
				},
			})
		end,
	},

	-- 不是天空中的 UFO，而是 Neovim 中的超级折叠。 za
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		opts = require("ui.fold").Opts,
		init = require("ui.fold").init,
		config = require("ui.fold").config,
	},

	-- 状态列插件，提供可配置的“状态列”和单击处理程序。需要 Neovim >= 0.10。
	-- statuscolumn
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- relculright = true,
				segments = {
					-- 书签
					{ sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = false } },
					-- 行号
					{ text = { builtin.lnumfunc } },
					-- 折叠
					{ text = { builtin.foldfunc } },
				},
			})
		end,
	},
}

return M
