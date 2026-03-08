return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.85,
        preview = {
          layout = "vertical",
          vertical = "down:55%",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    },
  },
}
