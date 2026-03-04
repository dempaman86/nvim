local keymap = vim.keymap.set

keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
keymap("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

keymap("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
  else
    vim.cmd("echo")
  end
end, { desc = "Clear highlight or escape", silent = true })

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fw", function()
  require("telescope.builtin").grep_string({
    search = vim.fn.expand("<cword>"),
    use_regex = false,
    word_match = "-w",
    only_sort_text = true,
    additional_args = { "--fixed-strings" },
  })
end, { desc = "Grep whole word under cursor" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>ft", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Find themes" })
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in current buffer" })

keymap("n", "<leader>gbb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branches" })
keymap("n", "<leader>gs", "<cmd>vert G<CR>", { desc = "Open Fugitive status" })
keymap("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
keymap("n", "<leader>gp", function()
  local upstream = vim.fn.system({ "git", "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}" })

  if vim.v.shell_error == 0 and upstream and upstream:gsub("%s+", "") ~= "" then
    vim.cmd("G push")
    return
  end

  local remotes = vim.fn.systemlist({ "git", "remote" })
  local remote = "origin"

  if vim.v.shell_error ~= 0 or #remotes == 0 then
    vim.notify("No git remote found for push", vim.log.levels.ERROR)
    return
  end

  if not vim.tbl_contains(remotes, "origin") then
    remote = remotes[1]
  end

  vim.cmd("Git push -u " .. remote .. " HEAD")
end, { desc = "Git push (set upstream if needed)" })
keymap("n", "<leader>gP", "<cmd>Git pull --rebase --autostash<CR>", { desc = "Git pull --rebase --autostash" })
keymap("n", "<leader>gf", "<cmd>Git fetch --prune<CR>", { desc = "Git fetch --prune" })
keymap("n", "<leader>gbf", function()
  vim.cmd("G blame --date=short")

  if vim.bo.filetype == "fugitiveblame" then
    local width = math.floor(vim.o.columns * 0.60)
    if width < 58 then
      width = 58
    end
    vim.cmd("vertical resize " .. width)
  end
end, { desc = "Fugitive blame (short date)" })
keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git vertical diff split" })
keymap("n", "<leader>gl", "<cmd>vert G log<CR>", { desc = "Git log" })

keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })

keymap("n", "<leader>ls", function()
  local registry = require("mason-registry")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local installed = registry.get_installed_packages()
  local lsp_names = {}

  for _, pkg in ipairs(installed) do
    local categories = pkg.spec.categories or {}
    if vim.tbl_contains(categories, "LSP") then
      table.insert(lsp_names, pkg.name)
    end
  end

  table.sort(lsp_names)

  pickers.new({}, {
    prompt_title = "Installed LSP Servers",
    finder = finders.new_table({ results = lsp_names }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        actions.close(bufnr)
        local selection = action_state.get_selected_entry()
        if selection and selection[1] then
          local name = selection[1]
          vim.lsp.enable(name)
          vim.cmd("LspStart " .. name)
          vim.notify("LSP started: " .. name)
        end
      end)
      return true
    end,
  }):find()
end, { desc = "LSP servers (Mason)" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto definition")
    map("n", "gr", vim.lsp.buf.references, "Goto references")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
  end,
})

keymap("n", "<leader>fn", "<cmd>execute 'edit ' . input('New file: ')<cr>", { desc = "New file" })
keymap("n", "<leader>fd", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local confirm = vim.fn.confirm("Delete file?\n" .. file, "&Yes\n&No", 2)
  if confirm == 1 then
    vim.fn.delete(file)
    vim.cmd("bdelete!")
  end
end, { desc = "Delete current file" })

keymap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

keymap("n", "<leader>tl", function()
  vim.g.lint_enabled = not vim.g.lint_enabled
  local status = vim.g.lint_enabled and "on" or "off"
  vim.notify("Lint: " .. status)
end, { desc = "Toggle lint" })

keymap("n", "<leader>tL", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    vim.lsp.stop_client(clients, true)
    vim.notify("LSP: off")
  else
    vim.cmd("LspStart")
    vim.notify("LSP: on")
  end
end, { desc = "Toggle LSP" })
