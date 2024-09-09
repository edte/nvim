local M = {}

M.goConfig = function()
    -- 如果开启，则和 lsp_lines.nvim 显示的报错冲突（会多显示 vture_text
    -- 如果关闭，则 go.nvim 很多功能用不了，如 gofillstruct等
    local go = try_require("go")
    if go == nil then
        return
    end
    go.setup()

    -- gn生成返回值
    -- keymap("", "gn", "<Cmd>GoGenReturn<cr>")
    -- -- gt填充struct
    -- keymap("", "gt", "<Cmd>GoFillStruct<cr>")

    Create_cmd("GoAddTagEmpty", function()
        vim.api.nvim_command(":GoAddTag json -add-options json=")
    end, { nargs = "*" })
end

return M
