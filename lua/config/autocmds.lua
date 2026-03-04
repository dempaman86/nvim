local augroup = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
    source = "if_many",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "always",
  },
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 120 })
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup,
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "line" })
  end,
})
