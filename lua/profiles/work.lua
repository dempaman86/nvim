local M = {}

function M.setup()
  -- ===========================================================================
  -- WORK PROFILE OVERRIDES
  -- ===========================================================================
  -- This function runs before any plugins or configs are loaded, meaning you
  -- can set global variables here or override anything you want.

  -- Example: Set work git email for the session
  -- vim.env.GIT_AUTHOR_EMAIL = "dennis@work.com"
  -- vim.env.GIT_COMMITTER_EMAIL = "dennis@work.com"

  -- Example: Change how telescope searches (e.g., search specifically in work folders)
  -- vim.keymap.set("n", "<leader>fw", "<cmd>Telescope find_files cwd=~/work<cr>", { desc = "Find Work Files" })

  -- Example: Specific tabstop/shiftwidth for a work codebase
  -- vim.opt.tabstop = 4
  -- vim.opt.shiftwidth = 4
end

return M
