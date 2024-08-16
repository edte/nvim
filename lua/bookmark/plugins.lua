local M = {}

M.list = {
	-- 文件mark，按git隔离
	-- 保存目录 /Users/edte/.cache/lvim/arrow
	{
		"otavioschwanck/arrow.nvim",
		keys = { "`" },
		opts = {
			show_icons = true,
			leader_key = "`", -- Recommended to be a single key
			-- buffer_leader_key = "m", -- Per Buffer Mappings
			index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
			save_key = "git_root", -- what will be used as root to save the bookmarks. Can be also `git_root`.
			hide_handbook = true,
			always_show_path = true,
		},
	},

	-- 命名书签
	-- echo stdpath("data")
	-- /Users/edte/.local/share/lvim
	-- ~/.local/share/nvim/bookmarks/
	{
		"crusj/bookmarks.nvim",
		keys = { "mm", "mo", "mD" },
		branch = "main",
		dependencies = {
			"nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("bookmarks").setup({
				storage_dir = "", -- Default path: vim.fn.stdpath("data").."/bookmarks,  if not the default directory, should be absolute path",
				mappings_enabled = true, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
				keymap = {
					toggle = " mt", -- Toggle bookmarks(global keymap)
					close = "<esc>", -- close bookmarks (buf keymap)
				},
				fix_enable = true,
			})
			require("telescope").load_extension("bookmarks")
			keymap("n", "mm", "<cmd>lua require'bookmarks'.add_bookmarks(fasle)<cr>")
			keymap("n", "mo", "<cmd>Telescope bookmarks<cr>")
			keymap("n", "mD", "<cmd>lua require'bookmarks.list'.delete_on_virt()<cr>")
		end,
	},

	-- -- 查看 Vim 标记并与之交互的用户体验更好。
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
					-- set_next = "mm",
					delete_line = "md",
					-- delete_buf = "mD",
					-- next = "m,",
					-- prev = "m.",
					-- preview = "m:",
				},
			})
		end,
	},
}

-- 默认将小写mark变成大写，小写谁用啊
-- Use lowercase for global marks and uppercase for local marks.
local low = function(i)
	return string.char(97 + i)
end
local upp = function(i)
	return string.char(65 + i)
end

-- 所有vim自带的mark都默认为大写
for i = 0, 25 do
	vim.keymap.set("n", "m" .. low(i), "m" .. upp(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "m" .. upp(i), "m" .. low(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. low(i), "'" .. upp(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. upp(i), "'" .. low(i))
end

return M
