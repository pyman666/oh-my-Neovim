-- Neovim 入口。
--
-- 1) 本机专属配置：参考 theniceboy/nvim 的 _machine_specific.vim 做法。
--    首次启动时从 machine.example.lua 复制出 machine.lua（后者不进备份），
--    之后只改 machine.lua 即可。删掉 machine.lua 可恢复出厂值。
local config_dir = vim.fn.stdpath("config") .. "/lua/config"
local machine_path = config_dir .. "/machine.lua"
local example_path = config_dir .. "/machine.example.lua"
if vim.fn.filereadable(machine_path) == 0 and vim.fn.filereadable(example_path) == 1 then
  vim.fn.writefile(vim.fn.readfile(example_path), machine_path)
end
pcall(require, "config.machine") -- 提供 vim.g.machine_python / vim.g.machine_winget_packages

-- 2) LazyVim 会自动加载 lua/config/{options,keymaps,autocmds}.lua 和 lua/plugins/*.lua。
require("config.lazy")
