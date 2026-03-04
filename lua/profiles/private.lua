local M = {}

function M.setup()
  -- ===========================================================================
  -- PRIVATE PROFILE OVERRIDES
  -- ===========================================================================
  -- This function runs before any plugins or configs are loaded, meaning you
  -- can set global variables here or override anything you want.

  -- Example: Set private git email for the session
  -- vim.env.GIT_AUTHOR_EMAIL = "your.private@email.com"
  -- vim.env.GIT_COMMITTER_EMAIL = "your.private@email.com"

  -- Example: Set a specific colorscheme override
  -- vim.cmd("colorscheme tokyonight-storm")

  -- Example: Add a private-only keybinding
  -- vim.keymap.set("n", "<leader>jp", "<cmd>echo 'Private Task'<cr>", { desc = "Private Task" })
end

return M
