-- 原 ~/.vimrc 里的 LSP autocmd 由 LazyVim 原生 LSP + pyright extra 取代。
-- 输入法切换由插件 vim-im-switch 自己的 autocmd 处理，这里无需重复配置。

-- 关掉拼写检查。
-- LazyVim 默认的 wrap_spell autocmd 会对 text/markdown/gitcommit 等文件设
-- spell=true（spelllang=en），中文文档会被英文词典标满红色波浪线（SpellBad）。
-- 这里删掉它，并重建一个只保留 wrap 的 autocmd。
-- 用户配置在 lazyvim.config.autocmds 之后加载，所以能可靠覆盖。
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_wrap", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})
