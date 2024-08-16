-- kitty 终端区分 c-i 和 tab
if vim.env.TERM == "xterm-kitty" then
	vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
	vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
	vim.cmd("nnoremap <c-i> <c-i>")
	vim.cmd("nnoremap <ESC>[105;5u <C-I>")
	vim.cmd("nnoremap <Tab>        %")
	vim.cmd("noremap  <ESC>[88;5u  :!echo B<CR>")
	vim.cmd("noremap  <ESC>[49;5u  :!echo C<CR>")
	vim.cmd("noremap  <ESC>[1;5P   :!echo D<CR>")
end

-- 交换 : ;

cmd("nnoremap ; :")
cmd("nnoremap : ;")

cmd("inoremap ; :")
cmd("inoremap : ;")

cmd("nnoremap <Enter> o<ESC>") -- Insert New Line quickly
-- cmd("nnoremap <Enter> %")

cmd("xnoremap p P")

cmd("silent!")

-- cmd("nnoremap # *")
-- cmd("nnoremap * #")

cmd("command! Pwd !ls %:p")
cmd("command! Cwd lua print(vim.fn.getcwd())")
