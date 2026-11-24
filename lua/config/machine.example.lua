-- ============================================================
-- 本机专属配置（machine.example.lua 进备份；machine.lua 只留本机）
--
-- 首次启动 Neovim 时会自动复制成 machine.lua（不进备份）。
-- 换机器后改 machine.lua 里的路径即可；
-- 想恢复出厂值：删掉 machine.lua，重启 Neovim 会从本模板重新生成。
--
-- 参考 theniceboy/nvim 的 _machine_specific.vim 做法：
-- 模板公开、实际值留本机，避免把个人路径写进主配置。
-- 按 OS 分支：Windows 用 winget + Python；macOS 用 im-select；
-- 其他平台暂时不启用输入法切换。
-- ============================================================

-- 内置终端 shell：留空则沿用系统默认 shell（Windows cmd.exe / macOS zsh）。
-- 【Win专属】要用 pwsh 就填真实 exe 路径；PATH 里的 pwsh 是 Store 的 0 字节 alias，
-- nvim 不能直接 jobstart 它。含空格的路径直接写字符串即可；
-- 要带参数就写 list，例如 { "cmd.exe", "/c", "pwsh" }。
vim.g.machine_terminal_shell = ""

local is_win = vim.fn.has("win32") == 1
local is_mac = vim.fn.has("macunix") == 1

if is_win then
  -- 输入法切换脚本 (bin/im_switch.py) 用的 Python 绝对路径
  vim.g.machine_python = "C:/Users/hen5szh/AppData/Local/anaconda3/python.exe"
  -- winget 安装根目录，options.lua 从这里探测 gcc/fd/rg；留空则跳过探测
  vim.g.machine_winget_packages = "~/AppData/Local/Microsoft/WinGet/Packages"
  -- Windows 输入法：US Keyboard / 微软拼音（也可直接写 1033 / 2052）
  vim.g.machine_im_en = "en"
  vim.g.machine_im_zh = "zh"

elseif is_mac then
  -- macOS 不需要 Python / winget，全部留空
  vim.g.machine_python = ""
  vim.g.machine_winget_packages = ""
  -- 和 Windows 同一个思路：直接切「输入源」而不是模拟切换键切「模式」。
  -- 系统有两个启用的输入源：ABC（英文）/ 简体拼音（中文）。
  -- 用 `im-select`（无参数）可查看当前 ID；切换：im-select <id>。
  vim.g.machine_im_select = "~/.local/bin/im-select"
  vim.g.machine_im_en = "com.apple.keylayout.ABC"
  vim.g.machine_im_zh = "com.apple.inputmethod.SCIM.ITABC"

else
  vim.g.machine_python = ""
  vim.g.machine_winget_packages = ""
end
