-- =================================================vim option settings=======================================================
-- 设置 vim 的剪切板与系统公用
vim.opt.clipboard = "unnamedplus"

vim.g.have_nerd_font = true

vim.opt.mouse = "a"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--=================================================luvar_vim general settings==============================================================
-- 日志等级
--lvim.log.level = "error"

-- lvim.log.level = "trace"
-- vim.lsp.set_log_level("trace")

-- 不可见字符的显示，这里只把空格显示为一个点
-- vim.o.list = false
-- vim.o.listchars = "space:·"

-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.hidden = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- -- 恢复上次会话
-- vim.opt.sessionoptions = 'buffers,curdir,tabpages,winsize'

-- -- tab 的空格数
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.o.scrolloff = 0

vim.filetype.add({
	extension = {
		tex = "tex",
		zir = "zir",
		cr = "crystal",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
	},
})

vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")

local default_options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" },
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
	foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
	hidden = true, -- required to keep multiple buffers and open multiple buffers
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	smartcase = true, -- smart case
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	title = true, -- set the title of window to the value of the titlestring
	-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
	-- undodir = undodir, -- set an undo directory
	undofile = true, -- enable persistent undo
	updatetime = 100, -- faster completion
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	-- shadafile = join_paths(get_cache_dir(), "lvim.shada"),
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
	sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
	showcmd = false,
	ruler = false,
	laststatus = 3,
}

for k, v in pairs(default_options) do
	vim.opt[k] = v
end
