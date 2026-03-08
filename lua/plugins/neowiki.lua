return {
  {
    "dempaman86/neowiki",
    branch = "main",
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
