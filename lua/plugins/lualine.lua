-- 状态栏：只做结构性覆盖，不改任何颜色，配色完全交给当前主题。
-- 1) LazyVim 默认 root_dir 在项目根目录时会隐藏目录名（cwd=false）；这里改成始终显示。
-- 2) python 环境做成可选组件：读到 VIRTUAL_ENV / CONDA_PREFIX 才显示，不装插件。
-- branch / diff / noice / lazy updates 等保持 LazyVim 默认，避免主题与自定义配色混杂。
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- 项目目录：即使 cwd 就是 git 根目录也显示出来；文件路径仍由 pretty_path 显示。
      opts.sections.lualine_c[1] = LazyVim.lualine.root_dir({ cwd = true })

      -- python 环境（可选）：只在有虚拟环境时显示，名字取目录名；颜色跟随主题。
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
          if not venv or venv == "" then
            return ""
          end
          return " " .. vim.fn.fnamemodify(venv, ":t")
        end,
      })

      return opts
    end,
  },
}
