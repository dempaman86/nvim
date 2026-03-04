local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local sitepath = vim.fn.stdpath("data") .. "/site"

if not vim.tbl_contains(vim.opt.runtimepath:get(), sitepath) then
  vim.opt.runtimepath:append(sitepath)
end

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
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
