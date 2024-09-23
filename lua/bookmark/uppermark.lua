-- 默认将小写mark变成大写，小写谁用啊
-- Use lowercase for global marks and uppercase for local marks.
local low = function(i)
    return string.char(97 + i)
end
local upp = function(i)
    return string.char(65 + i)
end

-- 所有vim自带的mark都默认为大写
for i = 0, 25 do
    if i ~= 3 and i ~= 12 and i ~= 14 then
        -- print(i, low(i))
        vim.keymap.set("n", "m" .. low(i), "m" .. upp(i))
    end
end
for i = 0, 25 do
    if i ~= 3 and i ~= 12 and i ~= 14 then
        vim.keymap.set("n", "m" .. upp(i), "m" .. low(i))
    end
end
for i = 0, 25 do
    if i ~= 3 and i ~= 12 and i ~= 14 then
        vim.keymap.set("n", "'" .. low(i), "'" .. upp(i))
    end
end
for i = 0, 25 do
    if i ~= 3 and i ~= 12 and i ~= 14 then
        vim.keymap.set("n", "'" .. upp(i), "'" .. low(i))
    end
end
