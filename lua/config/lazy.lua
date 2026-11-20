-- bootstrap lazy.nvim, LazyVim and your plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim 核心；沿用 everforest 配色
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "everforest" } },
    -- 从 ~/.vimrc 迁移过来的功能：文件树（替代 NERDTree）、Python LSP（pyright）
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
    { import = "lazyvim.plugins.extras.lang.python" },
    -- surround 用 LazyVim 官方的 mini.surround（gsa/gsd/gsr...，核心已预留 gs 分组）
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- 光标移动拖尾残影特效
    { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    -- 自己的插件
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "everforest", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
