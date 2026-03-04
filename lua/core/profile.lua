local M = {}

function M.load()
  local name = vim.env.NVIM_PROFILE or "private"
  local ok, profile = pcall(require, "profiles." .. name)

  if not ok then
    vim.notify("Unknown profile '" .. name .. "', using 'private'", vim.log.levels.WARN)
    profile = require("profiles.private")
    name = "private"
  end

  vim.g.nvim_profile = name

  if type(profile.setup) == "function" then
    profile.setup()
  end
end

return M
