return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local function setup_and_enable(server, config)
        vim.lsp.config(server, vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {}))
        vim.lsp.enable(server)
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "gopls",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "ts_ls",
          "yamlls",
        },
      })

      local servers = {
        "bashls",
        "gopls",
        "jsonls",
        "pyright",
        "ts_ls",
      }

      for _, server in ipairs(servers) do
        setup_and_enable(server)
      end

      setup_and_enable("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      setup_and_enable("marksman", {
        filetypes = { "markdown", "markdown.mdx", "vimwiki" },
      })

      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
            schemaStore = {
              enable = false,
            },
            schemas = {},
            format = {
              enable = false,
            },
          },
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        vimwiki = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },
}
