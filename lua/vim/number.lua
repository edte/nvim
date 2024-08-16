local M = {}

M.numberConfig = function()
	local augend = try_require("dial.augend")
	if augend == nil then
		return
	end
	local c = try_require("dial.config")
	if c == nil then
		return
	end
	c.augends:register_group({
		default = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
		},
		typescript = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.constant.new({ elements = { "let", "const" } }),
		},
		visual = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
			augend.constant.alias.alpha,
			augend.constant.alias.Alpha,
		},
	})

	local m = try_require("dial.map")
	if m == nil then
		return
	end

	-- 增强自增/自减
	-- change augends in VISUAL mode
	keymap("v", "<C-a>", m.inc_visual("visual"))
	keymap("v", "<C-x>", m.dec_visual("visual"))

	-- keymap("n", "<c-a>", try_require("dial.map").manipulate("increment", "normal"))
	-- keymap("n", "<c-x>", try_require("dial.map").manipulate("decrement", "normal"))
end

return M
