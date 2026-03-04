return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ft = { "markdown", "vimwiki" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "vimwiki" },
        heading = {
          backgrounds = {},
        },
        code = {
          highlight_inline = "Normal",
        },
      })
      vim.treesitter.language.register("markdown", "vimwiki")
    end,
  },
}
