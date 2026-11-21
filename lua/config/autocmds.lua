-- 原 ~/.vimrc 里的 LSP autocmd 由 LazyVim 原生 LSP + pyright extra 取代。
-- 输入法切换由 vim-im-switch 插件自己按 OS 注册 autocmd：
--   Windows → InsertLeave/Enter/Exit 异步调 Python + PostMessage
--   macOS   → 同样三个 autocmd 异步调 im-select (TIS API)，直接切输入源
-- 两个平台都不模拟按键、不切 IME 内部模式（那条路慢且不稳，见 README）。
-- 这里无需重复配置。

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

-- 打开真实文件后，自动把 cwd 切到该文件所属的 git 仓库根目录。
-- LazyVim 默认不自动 cd，若从子目录/别处启动 nvim，cwd 会停在非仓库目录，
-- 导致 snacks 的 git_status (<Space>gs) 等基于 git root 的功能报
-- "Command failed" + "No results found for git_status"。
-- 只对普通文件生效（跳过终端/quickfix/浮窗等 buftype 非空的 buffer）；
-- 仅在根目录与当前 cwd 不同时才 cd，避免反复触发 DirChanged。
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("user_auto_git_root", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" then
      return
    end
    local file = vim.api.nvim_buf_get_name(ev.buf)
    if file == "" then
      return
    end
    -- 注意：Windows 上这里不要传 type="both"（会导致 find 返回空）；
    -- 默认参数即可正确找到 .git（目录或文件均可）。
    local git = vim.fs.find(".git", { path = vim.fs.dirname(file), upward = true })
    if not git[1] then
      return
    end
    local root = vim.fs.normalize(vim.fn.fnamemodify(git[1], ":h"))
    local cwd = vim.fs.normalize(vim.fn.getcwd())
    local same = vim.fn.has("win32") == 1 and root:lower() == cwd:lower() or root == cwd
    if not same then
      vim.cmd("silent cd " .. vim.fn.fnameescape(root))
    end
  end,
})
