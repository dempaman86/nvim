# Neovim setup

This repository contains a modular Neovim configuration built on `lazy.nvim`.
The goal is a stable, practical setup for daily development.

## Quick start

1. Start Neovim:

```bash
nvim
```

2. Sync plugins on first launch:

```vim
:Lazy sync
```

## Repository structure

- `init.lua` - entry point
- `lua/config/` - options, keymaps, autocmds, lazy bootstrap
- `lua/plugins/` - plugin specs by feature

## Core plugins

- UI: Catppuccin, Lualine
- Navigation/Search: Telescope
- Syntax: Treesitter
- LSP: Mason, mason-lspconfig, nvim-lspconfig
- Completion: nvim-cmp + LuaSnip
- Git: Gitsigns
- Editing: Comment, autopairs, surround, which-key
- Formatting: Conform (format-on-save)
- Wiki: local `neowiki`

## Neowiki

`neowiki` is a local Lua plugin loaded from [`/Users/dennis/projects/neowiki`](/Users/dennis/projects/neowiki). It uses its own workspace root at `~/neowiki` and keeps notes in plain Markdown.

If the configured workspace root does not exist, `neowiki` now prompts to either create the directory with an `index.md` file or switch to another path for the current session.

- `:NeowikiOpen [page]` - open or create a page
- `<leader>ww` - enter Neowiki by opening the workspace index
- `:NeowikiFollow` - follow the wiki link under cursor
- `:NeowikiIndex` - open the workspace index page
- `:NeowikiSearch` - search pages with Telescope or `vim.ui.select`
- `:NeowikiBacklinks` - list backlinks to the current page
- `:NeowikiLinkCreate` - create a wiki link from the current word or visual selection
- `:NeowikiLinkNext` - jump to the next link in the current buffer
- `:NeowikiLinkPrev` - jump to the previous link in the current buffer
- `:NeowikiTable [cols] [rows]` - create a Markdown table below the current line
- `:NeowikiTableFormat` - format the Markdown table under cursor
- `:NeowikiTableAddColumnLeft` - add a column to the left of the current table cell
- `:NeowikiTableAddColumnRight` - add a column to the right of the current table cell
- `:NeowikiBack` - go back in neowiki history
- `:NeowikiForward` - go forward in neowiki history
- `:NeowikiRename [title]` - rename the current page and update wiki links
- `:NeowikiWorkspace [name]` - switch active workspace

In the current local setup, `Tab`, `Shift-Tab`, `Enter`, and `Backspace` are enabled inside `neowiki` buffers. Table navigation takes precedence when the cursor is inside a Markdown table; otherwise link navigation/history applies.

## Useful keybindings

- `<leader>gbb` - Telescope Git branches
- `<leader>gbl` - Toggle inline Git blame
- `<leader>gP` - `Git pull --rebase --autostash`
- In Telescope, `<C-s>` opens the selected entry in a vertical split.

## Symlink setup

Use this when you want the repo in `~/projects/nvim` but Neovim to read from `~/.config/nvim`:

```bash
mv ~/.config/nvim ~/projects/nvim
ln -s ~/projects/nvim ~/.config/nvim
```

If `~/projects/nvim` already exists and should be replaced:

```bash
rm -rf ~/projects/nvim
mv ~/.config/nvim ~/projects/nvim
ln -s ~/projects/nvim ~/.config/nvim
```

## Quick troubleshooting

- `:checkhealth` - Run Neovim health checks
- `:Lazy sync` - Reinstall/update plugins
- `:Mason` - Manage LSP servers and tools
