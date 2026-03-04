return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>gbl",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle git blame inline",
      },
    },
    init = function()
      local function set_blame_hl()
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {
          fg = "#f5e0dc",
          bg = "#1e1e2e",
          bold = true,
          italic = false,
        })
      end

      local function set_preview_hl()
        vim.api.nvim_set_hl(0, "GitsignsPreviewBorder", { link = "FloatBorder" })
      end

      local group = vim.api.nvim_create_augroup("user_gitsigns_blame_hl", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = function()
          set_blame_hl()
          set_preview_hl()
        end,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        group = group,
        callback = function()
          set_blame_hl()
          set_preview_hl()
        end,
      })
    end,
    opts = function(_, opts)
      opts.current_line_blame = false
      opts.current_line_blame_opts = vim.tbl_deep_extend("force", opts.current_line_blame_opts or {}, {
        virt_text = true,
        virt_text_pos = "right_align",
        virt_text_priority = 200,
        delay = 200,
      })

      opts.current_line_blame_formatter = "* <author>, <author_time:%Y-%m-%d> - <summary>"
      opts.preview_config = vim.tbl_deep_extend("force", opts.preview_config or {}, {
        border = "rounded",
      })

      return opts
    end,
  },
}
