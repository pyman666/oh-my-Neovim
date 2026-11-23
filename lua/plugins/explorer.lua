-- snacks.nvim (LazyVim 自带) 的文件树配置。
-- lazy.nvim 会把本条 opts 与 LazyVim 的 snacks_explorer extras 深度合并，
-- 这里只覆盖需要的项，不动其他默认设置。

-- 无文件参数启动 nvim 时自动打开文件树；带文件启动时不弹，避免遮挡代码。
-- nvim . 本来就由 snacks 的 replace_netrw 自动打开，这里用 argc()>0 跳过，避免重复。
-- 不再用 defer_fn：那会把打开推到启动之后，和 VeryLazy 插件加载撞在一起，
-- 表现为 tree 先出来、光标过一会儿才跳过去。这里同步打开并马上 focus。
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() > 0 then
      return
    end
    require("lazy").load({ plugins = { "snacks.nvim" } })
    local picker = Snacks.explorer({ cwd = LazyVim.root() })
    if not picker then
      return
    end
    picker:show()
    local ref = picker.ref and picker:ref()
    local function focus()
      local p = ref and ref() or picker
      if p and p.focus then
        p:focus("list")
      end
    end
    focus()
    -- 某些 UI 下 VimEnter 阶段 focus 不生效，UIEnter 再补一次（同 snacks 自带逻辑）。
    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = focus,
    })
  end,
})

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
