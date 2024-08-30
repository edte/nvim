---------------------------------------------------lsp-----------------------------------------------------------------------------------

local M = {}

M.lspConfig = function()
	-- 自动安装 lsp
	local lspconfig = try_require("lspconfig")
	if lspconfig == nil then
		return
	end

	-- vue
	lspconfig.volar.setup({
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	})
	lspconfig.cssls.setup({})
	lspconfig.tailwindcss.setup({})
	lspconfig.jsonls.setup({
		filetypes = { "json" },
	})
	lspconfig.tsserver.setup({})
	lspconfig.emmet_ls.setup({})
	lspconfig.marksman.setup({})
	lspconfig.emmet_language_server.setup({})
	lspconfig.html.setup({})
	lspconfig.autotools_ls.setup({})
	lspconfig.ruby_lsp.setup({
		filetypes = { "ruby" },
	})

	-- go
	local util = require("lspconfig/util")
	local lastRootPath = nil
	local gopath = os.getenv("GOPATH")
	if gopath == nil then
		gopath = ""
	end
	local gopathmod = gopath .. "/pkg/mod"

	lspconfig.gopls.setup({
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
				-- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
				hints = {
					-- rangeVariableTypes = true, -- 范围变量类型
					constantValues = true, -- 常数值
					assignVariableTypes = true, -- 分配变量类型
					compositeLiteralFields = true, -- 复合文字字段
					compositeLiteralTypes = true, -- 复合文字类型
					parameterNames = true, -- 参数名称
					functionTypeParameters = true, -- 函数类型参数
				},
			},
		},
		root_dir = function(fname)
			local fullpath = vim.fn.expand(fname, ":p")
			if string.find(fullpath, gopathmod) and lastRootPath ~= nil then
				return lastRootPath
			end
			lastRootPath = util.root_pattern("go.mod", ".git")(fname)
			return lastRootPath
		end,
		on_attach = M.on_attach,
		filetypes = { "go" },
	})

	-- lua
	lspconfig.lua_ls.setup({
		filetypes = { "lua" },
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "lvim" },
				},
				hint = {
					enable = true, -- necessary
				},
			},
		},
		handlers = {
			["textDocument/definition"] = function(err, result, ctx, config)
				if type(result) == "table" then
					result = { result[1] }
				end
				vim.lsp.handlers["textDocument/definition"](err, result, ctx, config)
			end,
		},
		on_attach = M.on_attach,
	})

	-- bash
	lspconfig.bashls.setup({
		filetypes = { "sh", "zsh", "tmux" },
		-- root_dir = nvim_lsp.util.root_pattern('.git'),
		-- root_dir = ".",
	})

	-- lspconfig.grammarly-languageserver.setup({})
	-- lspconfig.ltex-ls.setup({})

	-- yaml
	lspconfig["yamlls"].setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		filetypes = { "yaml" },
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "/*",
				},
			},
		},
	})

	-- cpp
	--
	-- 根目录下保存文件为 .clang-format
	-- BasedOnStyle: LLVM
	-- IndentWidth: 4
	-- ColumnLimit: 120

	local clangd_flags = {
		-- 默认格式化风格: 谷歌开源项目代码指南
		"--fallback-style=google",

		-- 建议风格：打包(重载函数只会给出一个建议）
		-- 相反可以设置为detailed
		"--completion-style=bundled",

		"--completion-style=detailed",
		"--header-insertion-decorators",
		"--enable-config",
		"--offset-encoding=utf-8",
		"--ranking-model=heuristics",
		-- 跨文件重命名变量
		-- "--cross-file-rename",
		-- 设置verbose时，会把编译命令和索引构建结果，占用内存等信息都打印出来，需要检查索引构建失败原因时，可以设置为verbose, error
		"--log=error",
		-- 输出的 JSON 文件更美观
		"--pretty",
		-- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
		"--header-insertion-decorators",
		-- "--folding-ranges",
		-- 在后台自动分析文件（基于complie_commands)
		"--background-index",
		-- 标记compelie_commands.json文件的目录位置
		-- "--compile-commands-dir=/Users/edte/go/src/login/test/wesing-backend-service-cpp/compile_commands.json",
		-- 告诉clangd用那个clang进行编译，路径参考which clang++的路径
		"--query-driver=/usr/bin/clang++",
		-- 启用 Clang-Tidy 以提供「静态检查」
		"--clang-tidy",
		-- Clang-Tidy 静态检查的参数，指出按照哪些规则进行静态检查，详情见「与按照官方文档配置好的 VSCode 相比拥有的优势」
		-- 参数后部分的*表示通配符
		-- 在参数前加入-，如-modernize-use-trailing-return-type，将会禁用某一规则
		-- "--clang-tidy-checks=cppcoreguidelines-*,performance-*,bugprone-*,portability-*,modernize-*,google-*",
		-- 默认格式化风格: 谷歌开源项目代码指南
		-- "--fallback-style=file",
		-- 同时开启的任务数量
		"-j=5",
		-- 全局补全（会自动补充头文件）
		"--all-scopes-completion",
		-- 更详细的补全内容
		"--completion-style=detailed",
		-- 补充头文件的形式
		"--header-insertion=iwyu",
		-- pch优化的位置(memory 或 disk，选择memory会增加内存开销，但会提升性能) 推荐在板子上使用disk
		"--pch-storage=memory",

		-- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符，乃至函数末
		"--function-arg-placeholders=true",
	}

	lspconfig.clangd.setup({
		cmd = { "clangd", unpack(clangd_flags) },
		on_attach = M.on_attach,
		init_options = {
			clangdFileStatus = true,
			-- compilationDatabasePath = "./build",
			fallback_flags = { "-std=c++17" },
		},
	})
end

M.on_attach = function(client, buf)
	if vim.fn.has("nvim-0.10") == 1 and client.supports_method("textDocument/inlayHint", { bufnr = buf }) then
		vim.lsp.inlay_hint.enable(true, { bufnr = buf })
	end
end

return M
