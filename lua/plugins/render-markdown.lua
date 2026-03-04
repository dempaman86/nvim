return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- mini.icons is standard nowadays, optionally nvim-web-devicons
    ft = { "markdown", "vimwiki" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "vimwiki" },
        heading = {
          -- Stäng av de blockiga bakgrundsfärgerna för rubriker för en renare look
          backgrounds = {},
        },
        code = {
          -- Stäng av bakgrundsfärgen för inline-kod (t.ex. `text`)
          highlight_inline = 'Normal',
        },
      })
      -- Registrera 'markdown' som parser för 'vimwiki'
      vim.treesitter.language.register("markdown", "vimwiki")
    end,
  },
}
