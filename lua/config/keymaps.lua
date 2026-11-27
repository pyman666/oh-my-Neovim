-- 从 ~/.vimrc 迁移的键位；LazyVim 自己的默认键位（gcc/gd/gr/K 等）保留。
local map = vim.keymap.set

-- 命令行里 %% 展开成当前文件所在目录
map("c", "%%", function()
  if vim.fn.getcmdtype() == ":" then
    return vim.fn.expand("%:h") .. "/"
  end
  return "%%"
end, { expr = true, desc = "Expand %% to current file directory" })

-- <C-l> 不再自定义：交还给 LazyVim 默认的窗口切换（与 C-h/j/k 一致）。
-- 搜索高亮由 LazyVim 默认的 <Esc>（noh）和 <leader>ur 清理，无需占用 C-l。

-- 普通/可视模式下 & 重复上一次替换（保留标志位）
map({ "n", "x" }, "&", ":&&<CR>", { silent = true, desc = "Repeat last :substitute" })

-- 可视模式下 * / # 搜索选中文本（字面匹配）
local function search_visual(direction)
  local saved = vim.fn.getreg("s")
  vim.cmd([[normal! gv"sy]])
  local selected = vim.fn.getreg("s")
  vim.fn.setreg("s", saved)
  local pattern = "\\V" .. vim.fn.substitute(vim.fn.escape(selected, direction .. "\\"), "\\n", "\\\\n", "g")
  vim.fn.setreg("/", pattern)
  local keys = direction .. vim.api.nvim_replace_termcodes("<C-r>=@/<CR><CR>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

map("x", "*", function() search_visual("/") end, { desc = "Search selection forward" })
map("x", "#", function() search_visual("?") end, { desc = "Search selection backward" })
