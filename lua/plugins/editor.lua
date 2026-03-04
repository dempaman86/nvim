return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 0,

      icons = {
        mappings = true, -- aktiverar Nerd Font ikoner
      },

      spec = {
        { "<leader>g", group = " Git" }, -- git-ikon från Nerd Font
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
