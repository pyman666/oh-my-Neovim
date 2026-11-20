-- ============================================================
-- 本机专属配置（machine.example.lua 进备份；machine.lua 只留本机）
--
-- 首次启动 Neovim 时会自动复制成 machine.lua（不进备份）。
-- 换机器后改 machine.lua 里的路径即可；
-- 想恢复出厂值：删掉 machine.lua，重启 Neovim 会从本模板重新生成。
--
-- 参考 theniceboy/nvim 的 _machine_specific.vim 做法：
-- 模板公开、实际值留本机，避免把个人路径写进主配置。
-- ============================================================

-- Python 解释器绝对路径：输入法切换脚本 (bin/im_switch.py) 用它调用。
-- 用绝对路径是为了避免 GUI 快捷方式 / 终端 PATH 不一致导致找不到 python。
vim.g.machine_python = "C:/Users/hen5szh/AppData/Local/anaconda3/python.exe"

-- winget 包安装根目录：options.lua 从这里探测 gcc / fd / rg。
-- 留空字符串 "" 则跳过探测（比如改用系统 PATH 里已有的工具）。
vim.g.machine_winget_packages = "~/AppData/Local/Microsoft/WinGet/Packages"
