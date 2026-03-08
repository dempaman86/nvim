return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 0,

      icons = {
        mappings = true,
      },

      spec = {
        { "<leader>g", group = " Git" },
        { "<leader>w", group = "󰖬 Neowiki" },
      },
    },
  },
}
