# Neovim setup (profiles)


Detta repo innehaller en Neovim-konfiguration byggd med `lazy.nvim` från grunden.
Målet är en stabil bas som funkar både privat och på jobb via profiler.

## Snabbstart

1. Starta Neovim:

```bash
nvim
```

2. Synka plugins första gången i Neovim:

```vim
:Lazy sync
```

## Profilhantering

- `private` laddas som default.
- Byt profil med env:

```bash
NVIM_PROFILE=work nvim
```

- Profilfiler finns i `lua/profiles/`.

## Struktur

- `init.lua` - entrypoint
- `lua/config/` - options, keymaps, autocmds, lazy bootstrap
- `lua/plugins/` - plugin-spec per doman
- `lua/profiles/` - profil-overlays (work/private)
- `lua/core/profile.lua` - profil-loader

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
