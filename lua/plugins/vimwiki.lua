local map = vim.keymap.set

return {
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki",
          syntax = "markdown",
          ext = ".md",
          index = "index",
        },
      }
    end,
    config = function()
      local function detach_lsp_from_current_buffer()
        local bufnr = vim.api.nvim_get_current_buf()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          pcall(vim.lsp.buf_detach_client, bufnr, client.id)
        end
      end

      local function toggle_vimwiki_markdown()
        local ft = vim.bo.filetype

        if ft == "vimwiki" then
          vim.bo.filetype = "markdown"
          pcall(vim.cmd, "LspStart")
          vim.notify("Filetype switched to markdown")
          return
        end

        if ft == "markdown" then
          detach_lsp_from_current_buffer()
          vim.bo.filetype = "vimwiki"
          vim.notify("Filetype switched to vimwiki")
          return
        end

        vim.notify("Filetype is not vimwiki or markdown", vim.log.levels.WARN)
      end

      map("n", "<leader>wm", toggle_vimwiki_markdown, { desc = "Vimwiki: toggle markdown" })
      map("n", "<C-t>", "<Plug>VimwikiToggleListItem", { remap = true, silent = true, desc = "Vimwiki: toggle todo" })
      map("n", "<leader>wt", "<cmd>VimwikiTable 2 2<CR>", { desc = "Vimwiki: insert table 2x2" })
    end,
  },
}
