-- 从 ~/.vimrc 迁移的插件 + 输入法切换插件。
-- LazyVim 已自带 lualine/gitsigns/ts-comments/nvim-lspconfig 等，不再重复装 airline/gitgutter/commentary/lsp。
return {
  {
    "pyman666/vim-im-switch",
    lazy = false,
    init = function()
      -- 用绝对路径（来自 machine.lua），避免 GUI 快捷方式 / 终端 PATH 不一致
      -- machine.lua 缺失时回退到 PATH 里的 python
      vim.g.vim_im_switch_python = vim.g.machine_python or "python"
      vim.g.vim_im_switch_on_enter = 1
      vim.g.vim_im_switch_on_leave = 1
      vim.g.vim_im_switch_on_exit = 1
    end,
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
    desc = "ys/cs/ds 修改包围符号",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    desc = "打开文件自动检测缩进",
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, remap = true, desc = "EasyAlign" },
    },
  },
  {
    "MattesGroeger/vim-bookmarks",
    event = "VeryLazy",
    desc = "mm/mn/mp/ma 书签；沿用原按键",
  },
}
