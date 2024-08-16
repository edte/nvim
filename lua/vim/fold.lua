local M = {}

-- :mkview,  Vim 并不会自动记忆手工折叠。但你可以使用以下命令，来保存当前的折叠状态：
-- :loadview, 在下次打开文档时，使用以下命令，来载入记忆的折叠信息：
-- zo 打开折叠文本
-- zc 关闭折叠
-- za 切换折叠。
-- zr	打开所有折叠
-- zR	打开所有折叠及其嵌套的折叠
-- zm	关闭所有折叠
-- zM	关闭所有折叠及其嵌套的折叠
-- zd	删除当前折叠
-- zE	删除所有折叠
-- zj	移动至下一个折叠
-- zk	移动至上一个折叠
-- zn	禁用折叠
-- zN	启用折叠

-- 手工折叠
-- zf, 后面跟文本对象
-- set foldmethod=manual

--  缩进折叠
-- :set foldmethod=indent

--  表达折叠
-- :set foldmethod=expr

--  语法折叠
-- :set foldmethod=syntax

--  差异 diff折叠
-- foldmethod=diff

--  标记折叠
-- :set foldmethod=marker
-- Vim 将 {{{和}}} 视为折叠指示符，并折叠它们之间的文本。通过标记折叠，Vim 会查找由'foldmarker' 选项定义的特殊标记来标记折叠区域。要查看 Vim 使用的标记，请运行：
-- :set foldmarker?

-- 延迟加载
M.foldConfig = function() end

return M
