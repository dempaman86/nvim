return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    timeout = 1200,
    render = "compact",
    stages = "fade",
    top_down = false,
    max_width = 60,
    background_colour = "#000000",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
