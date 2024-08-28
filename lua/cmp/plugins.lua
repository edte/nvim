local M = {}

M.list = {
  {
    "yioneko/nvim-cmp",
    branch = "perf",
    config = function()
      require("cmp.completion").cmpConfig()
    end,
    event = { "InsertEnter" },
    lazy = true,
    dependencies = {
      {
        "cmp-nvim-lsp",
        event = { "InsertEnter" },
      },
      {
        "cmp_luasnip",
        event = { "InsertEnter" },
      },
      -- {
      --   "cmp-buffer",
      --   event = { "InsertEnter" },
      -- },
      {
        url = "https://codeberg.org/FelipeLema/cmp-async-path",
        event = { "InsertEnter" },
      },
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "cmp-cmdline",
      -- 上下文语法补全
      {
        "ray-x/cmp-treesitter",
        event = { "InsertEnter" },
      },
      {
        "lukas-reineke/cmp-rg",
        event = { "InsertEnter" },
        lazy = true,
        enabled = function()
          return vim.fn.executable("rg") == 1
        end,
      },
      {
        "Snikimonkd/cmp-go-pkgs",
        event = { "InsertEnter" },
        ft = { "go" },
      },
      -- TabNine ai 补全
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        ft = { "lua", "go", "cpp" },
        event = { "InsertEnter" },
      },

      -- 单词补全
      {
        "uga-rosa/cmp-dictionary",
        event = { "InsertEnter" },
      },

      -- 计算器
      -- {
      --   "hrsh7th/cmp-calc",
      --   event = { "InsertEnter" },
      -- },

      --  表情符号源
      -- : 冒号触发
      -- {
      --   "hrsh7th/cmp-emoji",
      --   event = { "InsertEnter" },
      -- },

      -- nvim lua  源
      {
        "hrsh7th/cmp-nvim-lua",
        event = { "InsertEnter" },
        ft = { "lua" },
      },

      -- {
      --   "tzachar/cmp-fuzzy-path",
      --   event = { "InsertEnter" },
      --   dependencies = { "tzachar/fuzzy.nvim" },
      -- },
      -- {
      --   "tzachar/cmp-fuzzy-buffer",
      --   event = { "InsertEnter" },
      --   dependencies = { "tzachar/fuzzy.nvim" },
      -- },
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
    event = { "InsertEnter" },
  },

  -- 一个 Neovim 插件，用于将 vscode 风格的 TailwindCSS 补全添加到cmp
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

  -- cmp 的一个小函数，可以更好地对以一个或多个下划线开头的完成项进行排序。
  -- 在大多数语言中，尤其是 Python，以一个或多个下划线开头的项目应位于完成建议的末尾。
  -- { "lukas-reineke/cmp-under-comparator" },

  -- {
  -- 	"hrsh7th/cmp-omni",
  -- 	event = "VeryLazy",
  -- },

  -- -- cmp 的拼写源基于 vim 的拼写建议。
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

  -- lsp 输入法
  -- {
  -- 	"liubianshi/cmp-lsp-rimels",
  -- 	dependencies = {
  -- 		"neovim/nvim-lspconfig",
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
    event = { "InsertEnter" },
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- {
  -- 	"edte/copilot-cmp",
  -- 	config = function()
  -- 		require("copilot_cmp").setup()
  -- 	end,
  -- },
}

return M
