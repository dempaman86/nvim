return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.58,
          },
          width = 0.87,
          height = 0.80,
        },
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        color_devicons = true,
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        grep_string = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
    },
    config = function(_, opts)
      local actions = require("telescope.actions")
      local hl_group = vim.api.nvim_create_augroup("user_telescope_hl", { clear = true })

      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = vim.tbl_deep_extend("force", opts.defaults.mappings or {}, {
        i = {
          ["<C-s>"] = actions.select_vertical,
        },
        n = {
          ["<C-s>"] = actions.select_vertical,
        },
      })

      require("telescope").setup(opts)

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = hl_group,
        pattern = "*",
        callback = function()
          local function get_bg(name)
            local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
            return hl and (hl.bg or hl.background) or nil
          end
          local function get_fg(name)
            local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
            return hl and (hl.fg or hl.foreground) or nil
          end

          local bg_editor = get_bg("Normal")
          local bg_float = get_bg("NormalFloat") or bg_editor
          local bg_highlight = get_bg("CursorLine") or get_bg("ColorColumn") or bg_float

          if bg_editor and bg_float and bg_highlight then
            local hl_groups = {
              TelescopePromptNormal  = { bg = bg_highlight },
              TelescopePromptBorder  = { bg = bg_highlight, fg = bg_highlight },
              TelescopePromptPrefix  = { bg = bg_highlight, fg = get_fg("DiagnosticWarn") },
              TelescopePromptTitle   = { bg = get_fg("DiagnosticWarn"), fg = bg_editor, bold = true },

              TelescopeResultsNormal = { bg = bg_float },
              TelescopeResultsBorder = { bg = bg_float, fg = bg_float },
              TelescopePreviewNormal = { bg = bg_float },
              TelescopePreviewBorder = { bg = bg_float, fg = bg_float },

              TelescopeResultsTitle  = { fg = bg_float },
              TelescopePreviewTitle  = { bg = get_fg("DiagnosticInfo"), fg = bg_editor, bold = true },
            }

            for hl, col in pairs(hl_groups) do
              vim.api.nvim_set_hl(0, hl, col)
            end
          end
        end,
      })

      vim.cmd("doautocmd ColorScheme")

      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
