local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local sitepath = vim.fn.stdpath("data") .. "/site"

if not vim.tbl_contains(vim.opt.runtimepath:get(), sitepath) then
  vim.opt.runtimepath:append(sitepath)
end

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to clone lazy.nvim", vim.log.levels.ERROR)
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  rocks = {
    enabled = false,
  },
  defaults = {
    lazy = false,
  },
  install = {
    colorscheme = { "tokyonight" },
  },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  checker = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
})
