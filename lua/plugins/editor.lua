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
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
}
