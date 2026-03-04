return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          statusline = { "dashboard", "alpha" },
        },
      },

      sections = {
        -- Vänster sida
        lualine_a = { "mode" },

        lualine_b = {
          "branch",
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
          },
        },

        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },

        -- Höger sida
        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return ""
              end
              return " " .. clients[1].name
            end,
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
          },
          "filetype",
        },

        lualine_y = { "progress" },

        lualine_z = {
          {
            function()
              local profile = vim.g.nvim_profile or "unknown"
              return "󰆚 " .. profile:upper()
            end,
            color = function()
              if vim.g.nvim_profile == "work" then
                return { fg = "#ff9e64", gui = "bold" } -- Orange for work
              else
                return { fg = "#7aa2f7", gui = "bold" } -- Blue for private
              end
            end,
          },
          {
            "location",
            fmt = function(str)
              return str
            end,
          },
        },
      },
    },
  },
}
