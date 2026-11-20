-- snacks.nvim (LazyVim 自带) 的文件树配置。
-- lazy.nvim 会把本条 opts 与 LazyVim 的 snacks_explorer extras 深度合并，
-- 这里只覆盖需要的项，不动其他默认设置。
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,  -- 默认显示隐藏文件（点开头），无需每次按 H
          },
        },
      },
    },
  },
}
