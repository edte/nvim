--------------------------------------------------------------which key ------------------------------------------------------------------------

local wk = require("which-key")

local utils = require("telescope.utils")
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		require("fzf-lua").git_files()
	else
		require("fzf-lua").files()
	end
end

function compare_to_clipboard()
	local ftype = vim.api.nvim_eval("&filetype")
	vim.cmd(string.format(
		[[
  execute "normal! \"xy"
  vsplit
  enew
  normal! P
  setlocal buftype=nowrite
  set filetype=%s
  diffthis
  execute "normal! \<C-w>\<C-w>"
  enew
  set filetype=%s
  normal! "xP
  diffthis
  ]],
		ftype,
		ftype
	))
end

-- vim.keymap.set("x", "<Space>d", compare_to_clipboard)

wk.add({
	{
		mode = { "v" },
		{ "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "comment", nowait = true, remap = false },
		{ "<leader>l", group = "LSP", nowait = true, remap = false },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
		{ "<leader>t", ":'<,'>Translate ZH<cr>", desc = "Translate", nowait = true, remap = false },
		{ "<leader>d", ":lua compare_to_clipboard()<cr>", desc = "Diff", nowait = true, remap = false },
	},
})

wk.add({
	{
		"<leader>/",
		"<Plug>(comment_toggle_linewise_current)",
		desc = "comment",
		nowait = true,
		remap = false,
	},
	{
		"<leader>C",
		"<cmd>BufferCloseAllButCurrent<CR>",
		desc = "Close Other Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>c",
		"<cmd>bd<CR>",
		desc = "close Buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>e",
		"<cmd>lua ToggleMiniFiles()<CR>",
		desc = "Explorer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>f",
		"<cmd>lua project_files()<CR>",
		desc = "files",
		nowait = true,
		remap = false,
	},
	{ "<leader>g", group = "git", nowait = true, remap = false },
	{
		"<leader>gb",
		"<cmd>FzfLua git_branches<cr>",
		desc = "branch",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gc",
		"<cmd>FzfLua git_commits<cr>",
		desc = "commit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gd",
		"<cmd>Gitsigns diffthis HEAD<cr>",
		desc = "diff",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gl",
		"<cmd>lua require 'gitsigns'.blame_line()<cr>",
		desc = "blame",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gs",
		"<cmd>FzfLua git_status<cr>",
		desc = "status",
		nowait = true,
		remap = false,
	},
	{ "<leader>l", group = "lsp", nowait = true, remap = false },
	{
		"<leader>lI",
		"<cmd>Mason<cr>",
		desc = "Mason Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lS",
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		desc = "Workspace Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		desc = "Code Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ld",
		"<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
		desc = "Buffer Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>le",
		"<cmd>Telescope quickfix<cr>",
		desc = "Telescope Quickfix",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format()<cr>",
		desc = "Format",
		nowait = true,
		remap = false,
	},
	{
		"<leader>li",
		"<cmd>LspInfo<cr>",
		desc = "Info",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lj",
		"<cmd>lua vim.diagnostic.goto_next()<cr>",
		desc = "Next Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lk",
		"<cmd>lua vim.diagnostic.goto_prev()<cr>",
		desc = "Prev Diagnostic",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ll",
		"<cmd>lua vim.lsp.codelens.run()<cr>",
		desc = "CodeLens Action",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lq",
		"<cmd>lua vim.diagnostic.setloclist()<cr>",
		desc = "Quickfix",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lr",
		"<cmd>lua vim.lsp.buf.rename()<cr>",
		desc = "Rename",
		nowait = true,
		remap = false,
	},
	{
		"<leader>ls",
		"<cmd>Telescope lsp_document_symbols<cr>",
		desc = "Document Symbols",
		nowait = true,
		remap = false,
	},
	{
		"<leader>lw",
		"<cmd>Telescope diagnostics<cr>",
		desc = "Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>p",
		"<cmd>Lazy<cr>",
		desc = "plugins",
		nowait = true,
		remap = false,
	},
	{
		"<leader>q",
		"<cmd>confirm q<CR>",
		desc = "quit",
		nowait = true,
		remap = false,
	},
	{
		"<leader>r",
		"<cmd>Telescope oldfiles<CR>",
		desc = "recents",
		nowait = true,
		remap = false,
	},
	{ "<leader>s", group = "search", nowait = true, remap = false },
	{
		"<leader>sC",
		"<cmd>FzfLua colorschemes<cr>",
		desc = "Colorscheme",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sH",
		"<cmd>Telescope highlights<cr>",
		desc = "Find highlight groups",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sM",
		"<cmd>Telescope man_pages<cr>",
		desc = "Man Pages",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sR",
		"<cmd>Telescope registers<cr>",
		desc = "Registers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sa",
		"<cmd>FzfLua autocmds<cr>",
		desc = "autocmds",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sc",
		"<cmd>Telescope commands<cr>",
		desc = "Commands",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sf",
		"<cmd>Telescope find_files<cr>",
		desc = "Find File",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sh",
		"<cmd>Telescope help_tags<cr>",
		desc = "Find Help",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sk",
		"<cmd>FzfLua keymaps<cr>",
		desc = "Keymaps",
		nowait = true,
		remap = false,
	},
	{
		"<leader>sr",
		"<cmd>Telescope oldfiles<cr>",
		desc = "Open Recent File",
		nowait = true,
		remap = false,
	},
	{
		"<leader>st",
		"<cmd>Telescope live_grep<cr>",
		desc = "Text",
		nowait = true,
		remap = false,
	},
	{
		"<leader>t",
		"<cmd>FzfLua live_grep_native<CR>",
		desc = "text",
		nowait = true,
		remap = false,
	},
	{
		"<leader>L",
		"<cmd>edit" .. user_config_init .. "<CR>",
		desc = "config",
		nowait = true,
		remap = false,
	},
})
