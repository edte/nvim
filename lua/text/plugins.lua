local M = {}

M.list = {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- run = ":TSUpdate",
		cmd = {
			"TSInstall",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSInstallInfo",
			"TSInstallSync",
			"TSInstallFromGrammar",
			"TSBufToggle",
		},
		event = "User FileOpened",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			-- {
			-- 	"nvim-treesitter/nvim-treesitter-refactor",
			-- 	event = "BufRead",
			-- 	after = "nvim-treesitter",
			-- },
			-- {
			-- 	"theHamsta/nvim-treesitter-pairs",
			-- 	event = "BufRead",
			-- 	after = "nvim-treesitter",
			-- },
			-- 语法感知文本对象、选择、移动、交换和查看支持。
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "BufRead",
				after = "nvim-treesitter",
			},

			-- 文本对象增强
			{
				"RRethy/nvim-treesitter-textsubjects",
				lazy = true,
				event = { "User FileOpened" },
				after = "nvim-treesitter",
			},
			{
				"David-Kunz/treesitter-unit",
				event = { "User FileOpened" },
				after = "nvim-treesitter",
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				lazy = true,
			},
			-- 显示代码上下文,包含函数签名
			-- barbucue 的补充，显示更多
			{
				"nvim-treesitter/nvim-treesitter-context",
				after = "nvim-treesitter",
				event = "BufRead",
			},
			-- -- 使用treesitter自动关闭并自动重命名html标签
			{
				"windwp/nvim-ts-autotag",
				ft = { "html", "vue" },
				config = function()
					try_require("nvim-ts-autotag").setup()
				end,
			},
		},
		config = function()
			local r = try_require("text.treesitter")
			if r ~= nil then
				r.config()
			end
		end,
	},

	-- 用于分割/合并代码块的 Neovim 插件
	{
		"Wansmer/treesj",
		cmd = { "K" },
		config = function()
			local tsj = require("treesj")
			tsj.setup({
				use_default_keymaps = false,
			})
			vim.api.nvim_create_user_command("Toggle", function()
				require("treesj").toggle({ split = { recursive = false } })
			end, {})
		end,
	},

	-- 更好的注释生成器。支持多种语言和注释约定。
	{
		"danymat/neogen",
		after = "nvim-treesitter",
		keys = "gc",
		config = function()
			require("neogen").setup({})
			keymap("n", "gc", "<cmd>lua require('neogen').generate()<CR>")
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			require("text.telescope").config()
		end,
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			{ "telescope-fzf-native.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
		},
	},

	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				"telescope",
				fzf_opts = { ["--cycle"] = "" },
				winopts = {
					fullscreen = true,
				},
			})
		end,
	},

	-- 如果打开的文件很大，此插件会自动禁用某些功能。文件大小和要禁用的功能是可配置的。
	-- {
	-- 	"lunarvim/bigfile.nvim",
	-- 	config = function()
	-- 		require("text.bigfile").config()
	-- 	end,
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	event = { "FileReadPre", "BufReadPre", "User FileOpened" },
	-- },

	-- Telescope 扩展提供了有关通过lazy.nvim 安装的插件的便捷功能
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "tsakirist/telescope-lazy.nvim",
	},

	-- {
	-- 	url = "https://github.com/roginfarrer/fzf-lua-lazy.nvim.git",
	-- },
}

return M
