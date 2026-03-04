return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "yamllint",
      },
      run_on_start = true,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")
      local lint_timer

      local function clear_lint_timer()
        if not lint_timer then
          return
        end

        lint_timer:stop()
        lint_timer:close()
        lint_timer = nil
      end

      if vim.g.lint_enabled == nil then
        vim.g.lint_enabled = true
      end

      lint.linters_by_ft = {
        yaml = { "yamllint" },
      }

      local group = vim.api.nvim_create_augroup("user_lint", { clear = true })
      local function schedule_lint()
        if not vim.g.lint_enabled then
          return
        end

        clear_lint_timer()

        lint_timer = vim.uv.new_timer()
        lint_timer:start(200, 0, function()
          clear_lint_timer()
          vim.schedule(function()
            lint.try_lint()
          end)
        end)
      end

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
        group = group,
        callback = function()
          schedule_lint()
        end,
      })

      vim.api.nvim_create_autocmd({ "BufUnload", "VimLeavePre" }, {
        group = group,
        callback = function()
          clear_lint_timer()
        end,
      })
    end,
  },
}
