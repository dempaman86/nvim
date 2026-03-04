return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Sätt färgtemat här
      vim.cmd.colorscheme("catppuccin-mocha") -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      -- vim.cmd.colorscheme("tokyonight-night")
      -- vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
