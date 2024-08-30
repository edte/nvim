cmd("command! Pwd !ls %:p")
cmd("command! Cwd lua print(vim.fn.getcwd())")
