local M = {}

M.list = {

    -- 文件mark，按git隔离
    -- 保存目录 /Users/edte/.cache/lvim/arrow
    {
        "otavioschwanck/arrow.nvim",
        keys = { "`" },
        opts = {
            show_icons = true,
            leader_key = "`",                                                    -- Recommended to be a single key
            -- buffer_leader_key = "m", -- Per Buffer Mappings
            index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
            save_key = "git_root",                                               -- what will be used as root to save the bookmarks. Can be also `git_root`.
            hide_handbook = true,
            always_show_path = true,
        },
    },

    -- 命名书签
    -- echo stdpath("data")
    -- /Users/edte/.local/share/lvim
    -- ~/.local/share/nvim/bookmarks/
    {
        "edte/bookmarks.nvim",
        -- keys = { "mm", "mo", "mD" },
        branch = "main",
        dependencies = {
            "nvim-web-devicons",
        },
        init = function()
            keymap("n", "mm", function()
                print("test")
                require 'bookmarks'.add_bookmarks(false)
            end)
            keymap("n", "mo", "<cmd>lua require'bookmarks'.list_bookmarks_fzflua()<cr>")
            keymap("n", "mD", "<cmd>lua require'bookmarks.list'.delete_on_virt()<cr>")
        end,
        config = function()
            require("bookmarks").setup({
                storage_dir = "",        -- Default path: vim.fn.stdpath("data").."/bookmarks,  if not the default directory, should be absolute path",
                mappings_enabled = true, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
                keymap = {
                    toggle = " mt",      -- Toggle bookmarks(global keymap)
                    close = "<esc>",     -- close bookmarks (buf keymap)
                },
                fix_enable = true,
                fzflua = false,
            })
        end,
    },

    -- 查看 Vim 标记并与之交互的用户体验更好。
    {
        "chentoast/marks.nvim",
        config = function()
            local mark = try_require("marks")
            if mark == nil then
                return
            end

            mark.setup({
                -- whether to map keybinds or not. default true
                default_mappings = true,
                -- which builtin marks to show. default {}
                builtin_marks = { ".", "<", ">", "^" },
                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,
                -- how often (in ms) to redraw signs/recompute mark positions.
                -- higher values will have better performance but may cause visual lag,
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 250,
                -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
                -- marks, and bookmarks.
                -- can be either a table with all/none of the keys, or a single number, in which case
                -- the priority applies to all marks.
                -- default 10.
                sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
                -- disables mark tracking for specific filetypes. default {}
                excluded_filetypes = {},
                -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
                -- sign/virttext. Bookmarks can be used to group together positions and quickly move
                -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
                -- default virt_text is "".
                bookmark_0 = {
                    sign = "⚑",
                    virt_text = "hello world",
                    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                    -- defaults to false.
                    annotate = false,
                },
                mappings = {
                    delete_line = "md",
                },
            })
        end,
    },

    -- Neovim 的小型自动化会话管理器
    -- 当不带参数启动 nvim 时，AutoSession 将尝试恢复当前 cwd 的现有会话（如果存在）。
    -- 当启动 nvim 时。 （或另一个目录），AutoSession 将尝试恢复该目录的会话。
    -- 当启动 nvim some_file.txt （或多个文件）时，默认情况下，AutoSession 不会执行任何操作。有关更多详细信息，请参阅参数处理。
    -- 即使使用文件参数启动 nvim 后，仍然可以通过运行 :SessionRestore 手动恢复会话。
    -- 任何会话保存和恢复都会考虑当前工作目录 cwd。
    -- 当通过管道传输到 nvim 时，例如： cat myfile | nvim、AutoSession 不会做任何事情。
    -- ⚠️请注意，如果您的配置中有错误，恢复会话可能会失败，如果发生这种情况，自动会话将禁用当前会话的自动保存。仍然可以通过调用 :SessionSave 来手动保存会话。
    -- {
    --     "rmagatti/auto-session",
    --     -- cmd = { "SessionSave", "SessionRestore", "SessionDelete", "SessionToggleAutoSave", "SessionSearch" },
    --     config = function()
    --         require("auto-session").setup({
    --             log_level = "error",
    --             auto_session_suppress_dirs = { "~/", "~/Documents", "~/Projects", "~/Downloads", "/" },
    --             -- auto_session_use_git_branch = true,
    --             auto_save_enabled = true,
    --             bypass_save_filetypes = { "alpha", "dashboard" }, -- or whatever dashboard you use
    --         })
    --     end,
    -- },

    {
        dir = "bookmark.uppermark",
        config = function()
            require("bookmark.uppermark")
        end
    },

}


return M
