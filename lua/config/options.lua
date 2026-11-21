-- 从 ~/.vimrc 迁移过来的选项。
-- LazyVim 已设置的（如 number/relativenumber/signcolumn/expandtab/hlsearch/
-- incsearch/termguicolors/splitbelow/splitright/clipboard 等）不再重复。
-- 这里只保留原配置中跟 LazyVim 默认值不同、且仍有意义的项。

-- 按 OS 分支补齐外部 CLI：
-- Windows: winget 把 gcc/fd/rg 装到带 hash 的目录且只改用户 PATH，
--          已打开的终端不生效，所以这里直接探测并补进 Neovim 的 PATH。
-- macOS:   工具在 ~/.local/bin（zshrc 已加进 PATH），无需探测。
-- 其他:    假定工具已在 PATH。
if vim.fn.has("win32") == 1 then
  local winget_root = vim.g.machine_winget_packages or ""
  if winget_root ~= "" then
    local winget = vim.fn.expand(winget_root)
    local function find_exe(pattern)
      return vim.fn.globpath(winget, pattern, true, true)[1]
    end
    local function add_bin(exe)
      if not exe or exe == "" then return end
      local bin = vim.fn.fnamemodify(exe, ":h")
      if not vim.env.PATH:find(bin, 1, true) then
        vim.env.PATH = bin .. ";" .. vim.env.PATH
      end
    end

    local gcc = find_exe("BrechtSanders.WinLibs.POSIX.UCRT*/mingw64/bin/gcc.exe")
    if gcc and gcc ~= "" then
      vim.env.CC = gcc
      add_bin(gcc)
    end
    add_bin(find_exe("sharkdp.fd_*/**/fd.exe"))
    add_bin(find_exe("BurntSushi.ripgrep.MSVC_*/**/rg.exe"))
  end
elseif vim.fn.has("macunix") == 1 then
  -- macOS: fd/rg/tree-sitter 等都在 ~/.local/bin，PATH 已由 zshrc 设置
else
  -- Linux 等其他平台：假定工具已在 PATH
end

local opt = vim.opt

opt.nrformats = {}                  -- 数字统一按十进制处理
opt.belloff = "all"                 -- 关闭响铃
opt.swapfile = false                -- 不生成 swap 文件
opt.autoread = true                 -- 文件被外部修改时自动读取
opt.path:append({ "**", "~/" })     -- 沿用原来的文件搜索路径

opt.cursorcolumn = true             -- 高亮当前列（LazyVim 只默认高亮当前行）
opt.colorcolumn = "80,120"          -- 80/120 列参考线
opt.showcmd = true                  -- 命令行显示未完成的按键
opt.list = true
opt.listchars = { tab = "-->", trail = "~", nbsp = "␣" }

opt.tabstop = 4                     -- LazyVim 默认 2，按原配置改回 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smarttab = true

opt.fileformat = "unix"             -- 默认 LF 换行
opt.infercase = true
opt.wildignorecase = true
opt.wildcharm = 9                   -- <Tab>
opt.wildoptions = "pum"
opt.pumheight = 50                  -- LazyVim 默认 10，按原配置改回 50

opt.wrap = true                     -- LazyVim 默认 no-wrap，按原配置改回
opt.breakindent = true
opt.guifont = "JetBrainsMono Nerd Font Mono:h11"
