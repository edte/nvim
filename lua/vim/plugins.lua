local M = {}

M.list = {
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

  -- 使用“.”启用重复支持的插件映射
  {
    "tpope/vim-repeat",
    keys = { "." },
  },
  -- 增强 Neovim 中宏的使用。
  {
    "chrisgrieser/nvim-recorder",
    event = "RecordingEnter",
    keys = {
      { "q", desc = " Start Recording" },
      { "Q", desc = " Play Recording" },
    },
    opts = {},
  },

  -- 不是天空中的 UFO，而是 Neovim 中的超级折叠。 za
  -- 这里有点问题，昨天会变得非常的长
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = require("vim.fold").Opts,
    init = require("vim.fold").init,
    config = require("vim.fold").config,
  },

  -- Neovim 的 30 多个新文本对象捆绑包。
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = { "User FileOpened" },
    config = function()
      try_require("various-textobjs").setup({
        useDefaultKeymaps = true,
        lookForwardLines = 10,
      })
      -- example: `an` for outer subword, `in` for inner subword
      vim.keymap.set({ "o", "x" }, "aS", function()
        try_require("various-textobjs").subword(false)
      end)
      vim.keymap.set({ "o", "x" }, "iS", function()
        try_require("various-textobjs").subword(true)
      end)
    end,
  },

  -- 轻松添加/更改/删除周围的分隔符对。用Lua ❤️ 编写。
  --add:    ys{motion}{char},
  --delete: ds{char},
  --change: cs{target}{replacement},

  --     Old text                    Command         New text
  -- --------------------------------------------------------------------------------
  --     surr*ound_words             ysiw)           (surround_words)
  --     *make strings               ys$"            "make strings"
  --     [delete ar*ound me!]        ds]             delete around me!
  --     remove <b>HTML t*ags</b>    dst             remove HTML tags
  --     'change quot*es'            cs'"            "change quotes"
  --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  --     delete(functi*on calls)     dsf             function calls
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = { "ys", "ds", "cs" },
    config = function()
      try_require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- gx 打开 URL
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    -- you can specify also another config if you want
    config = function()
      try_require("gx").setup({
        open_browser_app = "open",          -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
        open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
        handlers = {
          plugin = true,                    -- open plugin links in lua (e.g. packer, lazy, ..)
          github = true,                    -- open github issues
          brewfile = true,                  -- open Homebrew formulaes and casks
          package_json = true,              -- open dependencies from package.json
          search = true,                    -- search the web/selection on the web if nothing else is found
        },
        handler_options = {
          search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
          -- search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
        },
      })
    end,
  },

  -- 长按j k 加速
  -- 卡顿
  {
    "rainbowhxch/accelerated-jk.nvim",
    keys = { "j", "k" },
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Cmd>lua require'accelerated-jk'.move_to('j')<cr>", {})
      vim.api.nvim_set_keymap("n", "k", "<Cmd>lua require'accelerated-jk'.move_to('k')<cr>", {})
      vim.api.nvim_set_keymap("n", "h", "<Cmd>lua require'accelerated-jk'.move_to('h')<cr>", {})
      vim.api.nvim_set_keymap("n", "l", "<Cmd>lua require'accelerated-jk'.move_to('l')<cr>", {})
      vim.api.nvim_set_keymap("n", "e", "<Cmd>lua require'accelerated-jk'.move_to('e')<cr>", {})
      vim.api.nvim_set_keymap("n", "b", "<Cmd>lua require'accelerated-jk'.move_to('b')<cr>", {})
    end,
  },

  -- 项目维度的替换插件
  -- normal 下按 \+r 生效
  {
    "MagicDuck/grug-far.nvim",
    cmd = "Replace",
    config = function()
      Setup("grug-far", {})
      -- require("grug-far").setup({})
      cmd("command! -nargs=* Replace GrugFar")
    end,
  },

  -- 像蜘蛛一样使用 w、e、b 动作。按子词移动并跳过无关紧要的标点符号。
  {
    "chrisgrieser/nvim-spider",
    keys = { "w" },
    -- lazy = true,
    config = function()
      keymap("", "w", "<cmd>lua require('spider').motion('w')<CR>")
      keymap("", "e", "<cmd>lua require('spider').motion('e')<CR>")
      keymap("", "b", "<cmd>lua require('spider').motion('b')<CR>")
    end,
  },

  -- Vim 的扩展 f、F、t 和 T 键映射。
  {
    "rhysd/clever-f.vim",
    keys = { "f" },
    config = function()
      vim.g.clever_f_across_no_line = 1
      vim.g.clever_f_mark_direct = 1
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_fix_key_direction = 1
      vim.g.clever_f_show_prompt = 1
      -- vim.api.nvim_del_keymap("n", "t")
    end,
  },

  -- Neovim 的排序插件，支持按行和分隔符排序。
  {
    "sQVe/sort.nvim",
    cmd = "Sort",
    config = function()
      require("sort").setup()
    end,
  },

  -- 在 Vim 中，在字符上按 ga 显示其十进制、八进制和十六进制表示形式。 Characterize.vim 通过以下补充对其进行了现代化改造：
  -- Unicode 字符名称： U+00A9 COPYRIGHT SYMBOL
  -- Vim 二合字母（在 <C-K> 之后键入以插入字符）： Co , cO
  -- 表情符号代码：： :copyright:
  -- HTML 实体： &copy;
  {
    "tpope/vim-characterize",
    keys = "ga",
  },

  -- 一个实用插件，可扩展 Lua 文件中的“gf”功能。
  -- gf 打开文件
  {
    "sam4llis/nvim-lua-gf",
    keys = "gf",
  },

  -- neovim 插件将文件路径和光标所在行复制到剪贴板
  {
    "diegoulloao/nvim-file-location",
    cmd = "Path",
    config = function()
      require("nvim-file-location").setup({
        -- keymap = 'yP',
        mode = "absolute",
        add_line = false,
        add_column = false,
        default_register = "*",
      })
      cmd("command! Path lua NvimFileLocation.copy_file_location('absolute', false, false)<cr>")
    end,
  },

  -- Neovim 中 vimdoc/帮助文件的装饰
  -- https://github.com/OXY2DEV/helpview.nvim
  {
    "OXY2DEV/helpview.nvim",
    lazy = true,
    event = "CmdlineEnter",
    -- ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Neovim 动作速度极快！
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    keys = "<M-m>",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      local hop = require("hop")
      vim.keymap.set("", "<M-m>", function()
        hop.hint_char1()
      end, { remap = true })
    end,
  },

  -- FIX: 这个插件有问题，会报 CursorHold 错误
  -- vim match-up：% 更好的导航和突出显示匹配单词现代 matchit 和 matchparen。支持 vim 和 neovim + tree-sitter。
  -- {
  --   "andymass/vim-matchup",
  -- },

  -- vim/neovim 的多光标插件
  -- 使用 Ctrl-D 选择单词
  -- 使用 Ctrl-Down/Ctrl-Up 垂直创建光标
  -- 使用 Shift-箭头一次选择一个字符
  -- 按 n/N 获取下一个/上一个出现的情况
  -- 按 [/] 选择下一个/上一个光标
  -- 按 q 跳过当前并获取下一个出现的位置
  -- 按 Q 删除当前光标/选择
  -- 使用 i,a,I,A 启动插入模式
  -- {
  -- 	"mg979/vim-visual-multi",
  -- 	branch = "master",
  -- 	-- keys = { "<c-d>" },
  -- 	init = function()
  -- 		vim.g.VM_maps = {
  -- 			-- ["Find Under"] = "<C-d>",
  -- 		}
  -- 	end,
  -- },

  -- 扩展递增/递减 ctrl+x/a
  -- {
  -- 	"monaqa/dial.nvim",
  -- 	config = function()
  -- 		local r = try_require("vim.number")
  -- 		if r ~= nil then
  -- 			r.numberConfig()
  -- 		end
  -- 	end,
  -- },

  -- -- 块移动
  -- {
  -- 	"fedepujol/move.nvim",
  -- 	event = "VeryLazy",
  -- 	config = function()
  -- 		try_require("move").setup({
  -- 			line = {
  -- 				enable = true, -- Enables line movement
  -- 				indent = true, -- Toggles indentation
  -- 			},
  -- 			block = {
  -- 				enable = true, -- Enables block movement
  -- 				indent = true, -- Toggles indentation
  -- 			},
  -- 			word = {
  -- 				enable = true, -- Enables word movement
  -- 			},
  -- 			char = {
  -- 				enable = false, -- Enables char movement
  -- 			},
  -- 		})
  -- 		-- local opts = { noremap = true, silent = true }
  -- 		-- -- Visual-mode commands
  -- 		-- vim.keymap.set("v", "<S-j>", ":MoveBlock(1)<CR>", opts)
  -- 		-- vim.keymap.set("v", "<S-k>", ":MoveBlock(-1)<CR>", opts)
  -- 		-- vim.keymap.set("v", "<S-h>", ":MoveHBlock(-1)<CR>", opts)
  -- 		-- vim.keymap.set("v", "<S-l>", ":MoveHBlock(1)<CR>", opts)
  -- 	end,
  -- },

  --  交互式对齐文本
  -- gaip=
  -- {
  -- 	"echasnovski/mini.align",
  -- 	version = false,
  -- 	config = function()
  -- 		require("mini.align").setup()
  -- 	end,
  -- },

  -- {
  -- 	"edte/normal-colon.nvim",
  -- 	keys = { ";" },
  -- 	-- event = "VeryLazy",
  -- 	-- opts = {},
  -- 	config = function()
  -- 		require("normal-colon").setup()
  -- 	end,
  -- },

  -- 借助独特的 f/F 指示器，移动速度更快。
  -- 和normal冲突，待解决
  -- {
  -- 	"jinh0/eyeliner.nvim",
  -- 	config = function()
  -- 		require("eyeliner").setup({
  -- 			-- show highlights only after keypress
  -- 			highlight_on_key = true,

  -- 			-- dim all other characters if set to true (recommended!)
  -- 			dim = true,

  -- 			-- set the maximum number of characters eyeliner.nvim will check from
  -- 			-- your current cursor position; this is useful if you are dealing with
  -- 			-- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
  -- 			max_length = 9999,
  -- 		})

  -- 		vim.g.clever_f_not_overwrites_standard_mappings = 1

  -- 		vim.keymap.set({ "n", "x", "o" }, "f", function()
  -- 			require("eyeliner").highlight({ forward = true })
  -- 			return "<Plug>(clever-f-f)"
  -- 		end, { expr = true })
  -- 	end,
  -- },

  -- 写vim文档用的
  -- {
  --   "jbyuki/venn.nvim",
  -- },

  -- Neovim 的小型自动化会话管理器
  {
    "rmagatti/auto-session",
    event = { "SessionSave", "SessionRestore", "SessionDelete", "SessionToggleAutoSave", "SessionSearch" },
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
    },
    opts = {
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
}

return M
