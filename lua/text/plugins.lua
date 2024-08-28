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
      {
        "nvim-treesitter/nvim-treesitter-refactor",
        event = "BufRead",
        after = "nvim-treesitter",
      },
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
    cmd = { "Toggle" },
    after = "nvim-treesitter",
    config = function()
      local tsj = require("treesj")
      tsj.setup({
        use_default_keymaps = false,
      })
      vim.api.nvim_create_user_command("Toggle", function()
        tsj.toggle({ split = { recursive = true } })
      end, {})
      -- print("jm")
      -- keymap("n", "gj", "<cmd>Toggle<CR>")
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
      -- Telescope.nvim 扩展程序可在从编辑历史记录中选择文件时提供智能优先级。
      -- :Telescope frecency
      -- " Use a specific workspace tag:
      -- :Telescope frecency workspace=CWD
      -- " You can use with telescope's options
      -- :Telescope frecency workspace=CWD path_display={"shorten"} theme=ivy
      -- {
      --   "nvim-telescope/telescope-frecency.nvim",
      --   config = function()
      --     require("telescope").load_extension("frecency")
      --   end,
      -- },
    },
  },

  -- {
  -- 	"Wansmer/sibling-swap.nvim",
  -- 	dependencies = "nvim-treesitter/nvim-treesitter",
  -- 	event = "VeryLazy",

  -- 	config = function()
  -- 		require("sibling-swap").setup({
  -- 			allowed_separators = {
  -- 				",",
  -- 				":",
  -- 				";",
  -- 				"and",
  -- 				"or",
  -- 				"&&",
  -- 				"&",
  -- 				"||",
  -- 				"|",
  -- 				"==",
  -- 				"===",
  -- 				"!=",
  -- 				"!==",
  -- 				"-",
  -- 				"+",
  -- 				["<"] = ">",
  -- 				["<="] = ">=",
  -- 				[">"] = "<",
  -- 				[">="] = "<=",
  -- 			},
  -- 			use_default_keymaps = true,
  -- 			-- Highlight recently swapped node. Can be boolean or table
  -- 			-- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
  -- 			-- `hl_opts` is a `val` from `nvim_set_hl()`
  -- 			highlight_node_at_cursor = true,
  -- 			-- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
  -- 			-- (`<C-,>` and `<C-.>` may not map to control chars at system level, so are sent by certain terminals as just `,` and `.`. In this case, just add the mappings you want.)
  -- 			keymaps = {
  -- 				["<a-1>"] = "swap_with_right",
  -- 				["<a-2>"] = "swap_with_left",
  -- 				["<space>."] = "swap_with_right_with_opp",
  -- 				["<space>,"] = "swap_with_left_with_opp",
  -- 			},
  -- 			ignore_injected_langs = false,
  -- 			-- allow swaps across lines
  -- 			allow_interline_swaps = true,
  -- 			-- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
  -- 			interline_swaps_without_separator = false,
  -- 			-- Fallbacs for tiny settings for langs and nodes. See #fallback
  -- 			fallback = {},
  -- 		})
  -- 	end,
  -- },

  -- 在 Neovim 中更改函数参数顺序！
  -- {
  -- 	"SleepySwords/change-function.nvim",
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		"nvim-treesitter/nvim-treesitter",
  -- 		"nvim-treesitter/nvim-treesitter-textobjects", -- Not required, however provides fallback `textobjects.scm`
  -- 	},
  -- 	config = function()
  -- 		local change_function = require("change-function")
  -- 		change_function.setup({})
  -- 		vim.api.nvim_set_keymap("n", "<leader>lR", "", {
  -- 			callback = change_function.change_function,
  -- 		})
  -- 	end,
  -- },

  --使用 Treesitter 对 Neovim 中的几乎所有内容进行排序
  -- {
  -- 	"mtrajano/tssorter.nvim",
  -- 	version = "*", -- latest stable version, use `main` to keep up with the latest changes
  -- 	cmd = "Sort",
  -- 	config = function()
  -- 		require("tssorter").setup({
  -- 			-- leave empty for the default config or define your own sortables in here. They will add, rather than
  -- 			-- replace, the defaults for the given filetype
  -- 		})
  -- 		cmd("command! -nargs=* Sort lua require('tssorter').sort()")
  -- 	end,
  -- },

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

  -- 暂时没用到过
  -- 🚦 漂亮的诊断、参考、望远镜结果、快速修复和位置列表，可帮助您解决代码造成的所有问题。
  -- {
  -- 	"folke/trouble.nvim",
  -- 	opts = {}, -- for default options, refer to the configuration section for custom setup.
  -- 	cmd = "Trouble",
  -- },

  -- 如果打开的文件很大，此插件会自动禁用某些功能。文件大小和要禁用的功能是可配置的。
  {
    "lunarvim/bigfile.nvim",
    config = function()
      require("text.bigfile").config()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
  },

  -- 用于使用 LSP、Tree-sitter 或正则表达式匹配自动突出显示光标下单词的其他用途
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        -- delay: delay in milliseconds
        delay = 120,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "lazy",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
      })
    end,
  },

  -- neovim 的一个插件，可以突出显示光标单词和行
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },
}

return M
