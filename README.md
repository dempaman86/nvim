# Neovim setup


Detta repo innehaller en Neovim-konfiguration byggd med `lazy.nvim` från grunden.
Målet är en stabil och enkel bas för vardaglig utveckling.

## Snabbstart

1. Starta Neovim:

```bash
nvim
```

2. Synka plugins första gången i Neovim:

```vim
:Lazy sync
```

## Struktur

- `init.lua` - entrypoint
- `lua/config/` - options, keymaps, autocmds, lazy bootstrap
- `lua/plugins/` - plugin-spec per doman

## Vanlig plugin-bas

- UI: Tokyonight, Lualine
- Navigation/Search: Telescope
- Syntax: Treesitter
- LSP: Mason, mason-lspconfig, nvim-lspconfig
- Completion: nvim-cmp + LuaSnip
- Git: Gitsigns
- Editing: Comment, autopairs, surround, which-key
- Formatting: Conform (format-on-save)

## Keybinding-notis (cross-platform)

- I Telescope (t.ex. via `<leader>ff`) öppnar `<C-s>` vald fil i vertical split.
