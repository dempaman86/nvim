return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Kräver make och gcc/clang
      },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            prompt_position = "top",
            preview_height = 0.70
          },
          width = 0.87,
          height = 0.80,
        },
        -- Avrunda hörn (ifall de syns alls efter våra highlight-ändringar)
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
      require("telescope").setup(opts)

      -- Auto-uppdatera highlightsen när färgtemat byts från Telescope
      vim.api.nvim_create_autocmd("ColorScheme", {
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

          -- Försök hitta vettiga bakgrunds/förgrundsfärger i det aktuella temat
          local bg_editor = get_bg("Normal")
          -- Använd Float-bakgrund (om den finns) eller Editor-bakgrunden för results/preview
          local bg_float = get_bg("NormalFloat") or bg_editor
          -- Skapa lite mer kontrast där man skriver (prompten) genom att sno färgen från CursorLine!
          local bg_highlight = get_bg("CursorLine") or get_bg("ColorColumn") or bg_float

          if bg_editor and bg_float and bg_highlight then
            local hl_groups = {
              -- Prompten får en färg ("lite mer kontrast där man skriver")
              TelescopePromptNormal  = { bg = bg_highlight },
              TelescopePromptBorder  = { bg = bg_highlight, fg = bg_highlight },
              TelescopePromptPrefix  = { bg = bg_highlight, fg = get_fg("DiagnosticWarn") },
              TelescopePromptTitle   = { bg = get_fg("DiagnosticWarn"), fg = bg_editor, bold = true },

              -- Resten får float-färgen (ofta lite mörkare/ljusare än editor-bakgrunden)
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

      -- Trigga omräkningen direkt vid uppstart så vi får rätt färger:
      vim.cmd("doautocmd ColorScheme")

      -- Ladda in fzf-sorteringsmotorn för extrem prestanda
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
