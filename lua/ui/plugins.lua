local M = {}

M.list = {
  -- 🏙 一个干净、深色的 Neovim 主题，用 Lua 编写，支持 lsp、treesitter 和许多插件。包括 Kitty、Alacritty、iTerm 和 Fish 的其他主题。
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

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
      },
      {
        "christopher-francisco/tmux-status.nvim",
        opts = {
          window = {
            separator = "  ",
            icon_zoom = "",
            icon_mark = "",
            icon_bell = "",
            icon_mute = "",
            icon_activity = "",
            text = "name",
          },
        },
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

      vim.g.loaded_netrw = false    -- or 1
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
      "lewis6991/gitsigns.nvim",  -- OPTIONAL: for git status
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
        keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
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
}

return M
