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
