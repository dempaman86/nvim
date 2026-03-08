return {
  {
    dir = vim.fn.expand("~/projects/neowiki"),
    name = "neowiki",
    config = function()
      require("neowiki.init").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/neowiki",
          },
        },
        default_workspace = "personal",
        extension = ".md",
        index = "index",
        picker = "telescope",
        keymaps = true,
      })
    end,
  },
}
