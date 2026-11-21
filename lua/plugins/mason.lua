-- 国内网络下 Mason 直连 GitHub 会失败（系统也没有 wget），每次启动都会报错。
-- stylua / shfmt / tree-sitter 已手动装到 ~/.local/bin，这里关掉 Mason 的自动
-- 下载和 registry 自动刷新。以后开着代理要装 LSP/工具时，手动执行 :MasonUpdate、:Mason。
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {}
      opts.registry_cache = opts.registry_cache or {}
      opts.registry_cache.refresh = false
    end,
  },
}
