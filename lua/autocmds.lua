-- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events

-- autocmd({ "VimLeave" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		require("plenary.profile").stop()
-- 	end,
-- })

-- 这段自动命令可以防止你在一个注释行中换行后，新行会继续注释的情况
Autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
    group = GroupId("comment_", { clear = true }),
})

-- 打开二进制文件
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

-- tmux 状态栏和vim 状态栏同步
Autocmd({ "VimLeavePre", "FocusLost", "VimSuspend" }, {
    group = GroupId("tmux-status-on", { clear = true }),
    callback = function()
        vim.system({ "tmux", "set", "status", "on" }, {}, function() end)
    end,
})

Autocmd({ "FocusGained", "VimResume" }, {
    group = GroupId("tmux-status-off", { clear = true }),
    callback = function()
        vim.system({ "tmux", "set", "status", "off" }, {}, function() end)
    end,
})

vim.system({ "tmux", "set", "status", "off" }, {}, function() end)

-- cursor word
-- 高亮当前光标下的单词
local MAX_LEN = 64

local function matchadd()
    local column = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local left = vim.fn.matchstr(line:sub(1, column + 1), [[\k*$]])
    local right = vim.fn.matchstr(line:sub(column + 1), [[^\k*]]):sub(2)
    local cursorword = left .. right

    if cursorword == vim.w.cursorword then
        return
    end

    vim.w.cursorword = cursorword

    if vim.w.cursorword_id then
        vim.fn.matchdelete(vim.w.cursorword_id)
        vim.w.cursorword_id = nil
    end

    if cursorword == "" or #cursorword > MAX_LEN or cursorword:find("[\192-\255]+") ~= nil then
        return
    end

    -- TODO: 在help文档中会报错，待优化
    vim.w.cursorword_id = vim.fn.matchadd("CursorWord", [[\<]] .. cursorword .. [[\>]], -1)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.api.nvim_set_hl(0, "CursorWord", { underline = true })
        matchadd()
    end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    callback = matchadd,
})

-- 在打开文件时跳转到上次编辑的位置
vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    group = GroupId('open-file-at-last-position', { clear = true }),
    pattern = '*',
    command = 'silent! normal! g`"zv'
})
