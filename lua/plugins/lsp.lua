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
        filetypes = { "markdown", "markdown.mdx", "neowiki" },
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
      require("snippets.neowiki").setup()

      local function neowiki_table_rank(entry)
        if entry.source.name ~= "luasnip" then
          return nil
        end

        local label = entry.completion_item.label
        if label == "table" then
          return { group = 1, size = 1 }
        end
        if label == "tabled" then
          return { group = 2, size = 1 }
        end

        local size = label:match("^table(%d+)$")
        if size then
          return { group = 1, size = tonumber(size) }
        end

        size = label:match("^table(%d+)d$")
        if size then
          return { group = 2, size = tonumber(size) }
        end

        return nil
      end

      local function compare_neowiki_tables(entry1, entry2)
        local rank1 = neowiki_table_rank(entry1)
        local rank2 = neowiki_table_rank(entry2)
        if not rank1 or not rank2 then
          return nil
        end

        if rank1.group ~= rank2.group then
          return rank1.group < rank2.group
        end

        if rank1.size ~= rank2.size then
          return rank1.size < rank2.size
        end
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
        sorting = {
          comparators = {
            compare_neowiki_tables,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
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
        neowiki = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },
}
