-- --==========================================luvar_vim keybinding settings===============================================================
-- 取消lunar的一些默认快捷键

vim.keymap.del("", "grr", {})
vim.keymap.del("", "gra", {})
vim.keymap.del("", "grn", {})

-- vim.cmd("nmap <tab> %")

keymap("n", "}", "}w")
keymap("n", "}", "}j")
cmd("nnoremap <expr><silent> { (col('.')==1 && len(getline(line('.')-1))==0? '2{j' : '{j')")

-- -- 上下滚动浏览
keymap("", "<C-j>", "5j")
keymap("", "<C-k>", "5k")

-- 保存文件
keymap("", "<C-s>", ":w<cr>")

-- 删除整行
keymap("", "D", "Vd")

keymap("n", "c", '"_c')

-- -- 设置 jj、jk 为 ESC,避免频繁按 esc
-- map("i", "jj", "<esc>", opt)
keymap("i", "jk", "<esc>")

-- 按 esc 消除上一次的高亮
keymap("n", "<esc>", ":noh<cr>")

vim.keymap.set("n", "<esc>", function()
	cmd(":nohlsearch")
	if isModuleAvailable("clever-f") then
		cmd(":call clever_f#reset()")
		return
	end
end, { desc = "esc", noremap = true, buffer = true })

-- 大小写转换
-- map("n", "<esc>", "~", opt)

-- what?
-- map("n", "<cmd>lua vim.lsp.buf.hover()<cr>", opt)

keymap("n", "yp", 'vi"p')
keymap("n", "vp", 'vi"p')

----------------------------------------------------------------
-- 取消撤销
keymap("n", "U", "<c-r>")

-- error 管理
keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error

-- 查看文档
-- keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- 重命名
-- keymap("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>")

vim.keymap.set("n", "R", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

keymap("n", "<bs>", "<C-^>")
keymap("", "gI", ":Glance implementations<cr>")
keymap("", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
keymap("", "gD", "<cmd>FzfLua lsp_declarations<cr>")
keymap("", "gr", "<cmd>Glance references<cr>")
keymap("n", "gh", "<CMD>ClangdSwitchSourceHeader<CR>")

keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error

-- gqn/gqj 自带的格式化
-- gm 跳屏幕中央
-- ga 显示字符编码
-- gs 等待重新映射
-- gv 最后的视觉选择
-- gi 上一个插入点
-- g* 类似于“*”，但不使用“\<”和“\>”

--------------------------------------------------------------screen ------------------------------------------------
------------------------------------------------------------------
--                          分屏
------------------------------------------------------------------
keymap("n", "s", "") -- 取消 s 默认功能
-- map("n", "S", "", opt)                          -- 取消 s 默认功能

-- 分屏状态下，一起滚动，用于简单的diff
-- set scrollbind
-- 恢复
-- set noscrollbind

keymap("n", "sv", ":vsp<CR>") -- 水平分屏
keymap("n", "sh", ":sp<CR>") -- 垂直分屏

keymap("n", "sc", "<C-w>c") -- 关闭当前屏幕
keymap("n", "so", "<C-w>o") -- 关闭其它屏幕

keymap("n", "s,", ":vertical resize +20<CR>") -- 向右移动屏幕
keymap("n", "s.", ":vertical resize -20<CR>") -- 向左移动屏幕

keymap("n", "sm", "<C-w>|") -- 全屏
keymap("n", "sn", "<C-w>=") -- 恢复全屏

keymap("n", "<a-,>", "<C-w>h") -- 移动到左分屏
keymap("n", "<a-.>", "<C-w>l") -- 移动到右分屏

-- 窗口切换
keymap("n", "<left>", "<c-w>h")
keymap("n", "<right>", "<c-w>l")
keymap("n", "<up>", "<c-w>k")
keymap("n", "<down>", "<c-w>j")
keymap("", "<c-h>", "<c-w>h")
keymap("", "<c-l>", "<c-w>l")
