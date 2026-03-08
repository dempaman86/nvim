return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ft = { "markdown", "neowiki" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "neowiki" },
        anti_conceal = {
          enabled = true,
        },
        pipe_table = {
          cell = "overlay",
          min_width = 3,
        },
        quote = {
          repeat_linebreak = true,
        },
        checkbox = {
          bullet = true,
        },
        latex = {
          enabled = false,
        },
        heading = {
          backgrounds = {},
        },
        code = {
          highlight_inline = "Normal",
        },
      })
      vim.treesitter.language.register("markdown", "neowiki")
    end,
  },
}
