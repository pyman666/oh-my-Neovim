-- 内置终端 shell 完全由 machine.lua 决定：
-- 填了就用它，留空则 Snacks 沿用系统默认 shell（vim.o.shell）。
-- 不碰 vim.o.shell，所以代码 / LSP / lint / format 链路不受影响。

local shell = vim.g.machine_terminal_shell

if shell == "" then
  shell = nil
elseif type(shell) == "string" then
  -- Snacks 会把字符串按空格拆成参数，含空格的路径会被拆坏；
  -- 包成 list 后原样传给 jobstart，一个元素就是完整路径。
  -- 需要带参数时请在 machine.lua 里直接写 list，例如 { "cmd.exe", "/c", "pwsh" }。
  shell = { shell }
end

return {
  "snacks.nvim",
  opts = shell and { terminal = { shell = shell } } or {},
}
