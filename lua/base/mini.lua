-- 最小配置

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{
		"gbprod/substitute.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			require("substitute").setup()

			-- map helper function:
			-- The function bellow had an important update I started using vim.keymap.set
			-- which uses lua functions directly instead of vim.api.nvim_set_keymap
			-- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
			local function map(mode, lhs, rhs, opts)
				local options = { noremap = true, silent = true }
				if opts then
					options = vim.tbl_extend("force", options, opts)
				end
				vim.keymap.set(mode, lhs, rhs, options)
			end

			-- substitute plugin:
			map("n", "s", "<cmd>lua require('substitute').operator()<cr>")
			map("n", "ss", "<cmd>lua require('substitute').line()<cr>")
			map("n", "S", "<cmd>lua require('substitute').eol()<cr>")
			map("x", "s", "<cmd>lua require('substitute').visual()<cr>")
			map("n", "sx", "<cmd>lua require('substitute.exchange').operator()<cr>")
			map("n", "sxx", "<cmd>lua require('substitute.exchange').line()<cr>")
			map("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>")
			map("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<cr>")
		end,
	},
})
