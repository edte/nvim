local M = {}

M.list = {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp.completion").cmpConfig()
		end,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"cmp-nvim-lsp",
			"cmp_luasnip",
			"cmp-buffer",
			"cmp-path",
			"cmp-cmdline",
			-- 上下文语法补全
			{
				"ray-x/cmp-treesitter",
			},
			-- TabNine ai 补全
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				dependencies = "hrsh7th/nvim-cmp",
				ft = { "lua", "go", "cpp" },
			},

			-- 单词补全
			{
				"uga-rosa/cmp-dictionary",
				event = "BufRead",
			},

			-- 计算器
			{
				"hrsh7th/cmp-calc",
				event = "BufRead",
			},

			-- nvim-cmp 表情符号源
			-- : 冒号触发
			{
				"hrsh7th/cmp-emoji",
				event = "BufRead",
			},

			-- nvim lua 的 nvim-cmp 源
			{
				"hrsh7th/cmp-nvim-lua",
				event = "BufRead",
			},

			{
				"tzachar/cmp-fuzzy-path",
				event = "BufRead",
				dependencies = { "tzachar/fuzzy.nvim" },
			},
			{
				"tzachar/cmp-fuzzy-buffer",
				event = "BufRead",
				dependencies = { "tzachar/fuzzy.nvim" },
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"friendly-snippets",
		},
	},
	{ "rafamadriz/friendly-snippets", lazy = true },
	{
		"folke/neodev.nvim",
		lazy = true,
	},

	-- 一个 Neovim 插件，用于将 vscode 风格的 TailwindCSS 补全添加到 nvim-cmp
	-- {
	-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
	-- 	event = "VeryLazy",
	-- 	-- optionally, override the default options:
	-- 	config = function()
	-- 		try_require("tailwindcss-colorizer-cmp").setup({
	-- 			color_square_width = 2,
	-- 		})

	-- 		lvim.builtin.cmp.formatting = {
	-- 			format = require("tailwindcss-colorizer-cmp").formatter,
	-- 		}
	-- 	end,
	-- },

	-- nvim-cmp 的一个小函数，可以更好地对以一个或多个下划线开头的完成项进行排序。
	-- 在大多数语言中，尤其是 Python，以一个或多个下划线开头的项目应位于完成建议的末尾。
	-- { "lukas-reineke/cmp-under-comparator" },

	-- nvim-cmp 源代码用于显示强调当前参数的函数签名：
	-- {
	-- 	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- },

	-- {
	-- 	"hrsh7th/cmp-omni",
	-- 	event = "VeryLazy",
	-- },

	-- -- nvim-cmp 的拼写源基于 vim 的拼写建议。
	-- {
	-- 	"f3fora/cmp-spell",
	-- 	config = function()
	-- 		vim.opt.spell = true
	-- 		vim.opt.spelllang:append("en_us")
	-- 	end,
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"andersevenrud/cmp-tmux",
	-- },

	-- {
	-- 	"petertriho/cmp-git",
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = { "tzachar/cmp-ai" },
	-- },

	-- lsp 输入法
	-- {
	-- 	"liubianshi/cmp-lsp-rimels",
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"hrsh7th/nvim-cmp",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 	},
	-- 	config = function()
	-- 		require("rimels").setup({
	-- 			shared_data_dir = "/Library/Input Methods/Squirrel.app/Contents/SharedSupport", -- MacOS: /Library/Input Methods/Squirrel.app/Contents/SharedSupport
	-- 		})
	-- 	end,
	-- },

	-- 语言字典补全
	{
		"skywind3000/vim-dict",
		event = "VeryLazy",
	},

	{
		"edte/copilot",
		ft = { "lua", "go", "cpp" },
	},

	-- Autopairs
	-- 用 lua 编写的 Neovim 自动配对
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
	},

	-- {
	-- 	"edte/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}

return M
