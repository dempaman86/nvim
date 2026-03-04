# Neovim setup (sandbox + profiles)


Detta repo innehaller en Neovim-konfiguration byggd med `lazy.nvim` från grunden.
Målet är en stabil bas som funkar både privat och på jobb via profiler.

## Snabbstart

1. Starta sandbox med privat profil:

```bash
./scripts/nvim-sandbox
```

2. Starta sandbox med jobbprofil:

```bash
./scripts/nvim-sandbox work
```

3. Synka plugins första gången i Neovim:

```vim
:Lazy sync
```

## Profilhantering

- `private` laddas som default.
- Byt profil med argument till scriptet eller env:

```bash
NVIM_PROFILE=work ./scripts/nvim-sandbox
```

- Profilfiler finns i `lua/profiles/`.

## Struktur

- `init.lua` - entrypoint
- `lua/config/` - options, keymaps, autocmds, lazy bootstrap
- `lua/plugins/` - plugin-spec per doman
- `lua/profiles/` - profil-overlays (work/private)
- `lua/core/profile.lua` - profil-loader
- `scripts/nvim-sandbox` - fullisolerad sandbox launcher

## Vanlig plugin-bas

- UI: Tokyonight, Lualine
- Navigation/Search: Telescope
- Syntax: Treesitter
- LSP: Mason, mason-lspconfig, nvim-lspconfig
- Completion: nvim-cmp + LuaSnip
- Git: Gitsigns
- Editing: Comment, autopairs, surround, which-key
- Formatting: Conform (format-on-save)
