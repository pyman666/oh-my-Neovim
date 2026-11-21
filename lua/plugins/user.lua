-- 从 ~/.vimrc 迁移的插件；LazyVim 已自带 lualine/gitsigns/ts-comments/nvim-lspconfig 等，
-- 不再重复装 airline/gitgutter/commentary/lsp。
-- surround / 注释也已改用 LazyVim 官方方案（mini.surround / 原生 gc），见 lazy.lua。
--
-- 输入法切换：一套代码同时兼容 Windows / macOS，由 lazy.nvim 按标准方式安装。
-- 配置层不做 OS 判断；后端选择全在插件内部：
--   has('win32')   -> Python + PostMessage(WM_INPUTLANGCHANGEREQUEST)
--   has('macunix') -> im-select + TISSelectInputSource
local im_switch = {
  "pyman666/vim-im-switch",
  lazy = false,
  init = function()
    -- 只透传 machine.lua 里的本机值；en/zh 的 OS 默认值由插件内部决定。
    if vim.g.machine_python and vim.g.machine_python ~= "" then
      vim.g.vim_im_switch_python = vim.g.machine_python
    end
    if vim.g.machine_im_select and vim.g.machine_im_select ~= "" then
      vim.g.vim_im_switch_im_select = vim.g.machine_im_select
    end
    if vim.g.machine_im_en and vim.g.machine_im_en ~= "" then
      vim.g.vim_im_switch_en = vim.g.machine_im_en
    end
    if vim.g.machine_im_zh and vim.g.machine_im_zh ~= "" then
      vim.g.vim_im_switch_zh = vim.g.machine_im_zh
    end
    vim.g.vim_im_switch_on_enter = 1
    vim.g.vim_im_switch_on_leave = 1
    vim.g.vim_im_switch_on_exit = 1
  end,
}

return {
  im_switch,
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
  -- vimrc 里的 vim-table-mode：<leader>ta 开关，表格角符用 |
  {
    "dhruvasagar/vim-table-mode",
    init = function()
      vim.g.table_mode_corner = "|"
    end,
    keys = {
      { "<leader>ta", "<cmd>TableModeToggle<CR>", desc = "Toggle table mode (old vimrc key)" },
    },
  },
}
