return {
  {
    "sainnhe/everforest",
    priority = 1000,
    lazy = false,
    init = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_better_diffs = 1
      vim.g.everforest_transparent_background = 0
    end,
    config = function()
      vim.cmd.colorscheme("everforest")
    end,
  },
}
