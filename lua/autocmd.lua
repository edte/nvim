-- 这段自动命令可以防止你在一个注释行中换行后，新行会继续注释的情况
Autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

-- autocmd({ "VimLeave" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		require("plenary.profile").stop()
-- 	end,
-- })

cmd([[
	" vim -b : edit binary using xxd-format!
	augroup Binary
	  autocmd!
	  autocmd BufReadPre  *.bin set binary
	  autocmd BufReadPost *.bin
	    \ if &binary
	    \ |   execute "silent %!xxd -c 32"
	    \ |   set filetype=xxd
	    \ |   redraw
	    \ | endif
	  autocmd BufWritePre *.bin
	    \ if &binary
	    \ |   let s:view = winsaveview()
	    \ |   execute "silent %!xxd -r -c 32"
	    \ | endif
	  autocmd BufWritePost *.bin
	    \ if &binary
	    \ |   execute "silent %!xxd -c 32"
	    \ |   set nomodified
	    \ |   call winrestview(s:view)
	    \ |   redraw
	    \ | endif
	augroup END
]])

-- 如果你安装了诸如 neotree 或 nvim-tree 这种大纲性质的插件并且它们被打开时，那么你可能希望在当前缓冲区删除的时候不会影响到现有的窗口布局。上面的自动命令 BUfferDelete 很好的完成了这件事。所以，再见 bufdelete.nvim 插件，该命令灵感来源于 NvChad 的早期版本。
Create_cmd("BufferDelete", function()
	---@diagnostic disable-next-line: missing-parameter
	local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
	local modified = vim.api.nvim_buf_get_option(0, "modified")
	if file_exists == 0 and modified then
		local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
		if user_choice == "y" or string.len(user_choice) == 0 then
			vim.cmd("bd!")
		end
		return
	end
	local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
	vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })
