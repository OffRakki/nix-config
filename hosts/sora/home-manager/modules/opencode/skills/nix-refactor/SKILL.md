---
name: nix-refactor
description: Systematic NixOS flake audit and refactoring. Covers full-read discovery, redundancy detection, dead code cleanup, package deduplication, unused input removal, and flake validation. Use when the user asks for a config review, cleanup, or refactor.
---

# Nix Config Audit & Refactor

A repeatable workflow for reviewing and cleaning up a NixOS flake config.

## Workflow

### 1. Map the territory

```
find . -type f | sort        # Full file listing
```

Exclude `.git/` and `.jj/` internals. Get a high-level mental model:
how many machines, which modules are shared vs per-host, what's the
WM, secrets strategy, filesystem layout, etc.

Key things to identify up front:
- Hosts: how many machines, their roles (desktop/server/VM)
- Module structure: shared vs per-host modules
- Inputs: what flakes are declared
- Secrets: sops, age, impermanence
- WM: Hyprland, KDE, standalone, etc.
- State: is the repo using `jj`, `git`, or both?

### 2. Full read

Read every `.nix` file, every script, every config template. Do NOT
skip files that seem trivial. You're looking for:

- **Intra-file duplicates**: same package listed twice in one list
- **Cross-file duplicates**: same package in `packages.nix` and `home-packages.nix`
- **`enable = false` with full config**: detailed config for a disabled service
- **Commented-out code** that masks dead imports
- **Stale paths**: references to files or directories that don't exist
- **Unused flake inputs**: declared in `flake.nix` but never imported
- **Redundant defaults**: options like `services.dbus.enable = true`
  (already the default)
- **Inconsistencies**: same option set differently on different hosts
  without clear intent
- **Locales**: all 14 `LC_*` vars set individually when just setting
  `i18n.defaultLocale` would cover most

### 3. Verify assumptions before touching anything

Before declaring something "unused" or "dead", search the entire codebase:

```bash
grep -r "thingImRemoving" --include="*.nix" hosts/
```

Also check `flake.lock` for stale inputs. An input might appear unused
in `.nix` files but still be evaluated via the module system or overlays.

For duplicate service definitions (same service defined in two modules),
check if Nix's module system merges them cleanly (different attributes
on the same service) or conflicts (same attribute set twice).

### 4. Categorize changes by confidence

| Confidence | Type | Examples |
| ---------- | ---- | -------- |
| High | Obvious dupes, dead config | Intra-file package dupes, `enable = false` modules |
| Medium | Cross-module duplication | Glance YAML copied across hosts |
| Low | Architectural | Module structure, flake input hygiene |

### 5. Execute changes systematically

**Order matters**. Do high-confidence, low-risk changes first:

1. **Inter-file dedup** -- remove duplicate package lines within a file
2. **Cross-file dedup** -- remove from system packages when HM has it
   (prefer HM for user-facing tools)
3. **Dead module cleanup** -- remove disabled module imports,
   delete orphaned files
4. **Unused inputs** -- remove from `flake.nix` and `nixConfig` cachix
5. **i18n/locale cleanup** -- collapse redundant settings
6. **Shared abstraction** -- extract duplicated blocks into a shared
   module (e.g. Glance dashboard YAML)

When deduplicating packages between NixOS and home-manager:
- **System level** (`environment.systemPackages`): packages needed before
  login, by system services, or by all users
- **HM level** (`home.packages`): user-facing tools, GUI apps, dev tools,
  shell utilities

If a package is in both, prefer the HM copy unless there's a clear
system-level dependency (e.g. secrets tools like `sops`/`age` need to
be at system level for activation scripts).

### 6. Path resolution traps

When using `import` with relative paths, count `..` carefully. A common
mistake is one level too many or too few.

From `hosts/sora/nixos/containers/containers.nix`:
```
../../../modules/foo.nix   # correct: resolves to hosts/modules/foo.nix
../../../../modules/foo.nix # WRONG: resolves to modules/foo.nix (above repo root)
```

Count: `..` = `containers/`, `../..` = `nixos/`, `../../..` = `sora/`,
`../../../..` = `hosts/`. So `../../../modules/` = `hosts/modules/`.

The error message when you get it wrong:
```
error: getting status of '.../source/modules/foo.nix': No such file or directory
```

If the path in the error shows `<root>/modules/...` instead of
`<root>/hosts/modules/...`, you have one too many `..`.

### 7. Validate

```bash
nix flake check --no-build    # Must exit 0
```

Warnings (deprecation notices, catppuccin enrollment, etc.) are fine.
Errors are not. Fix any evaluation errors before declaring done.

Then format:
```bash
nix run nixpkgs#alejandra .
```

Re-run `nix flake check` after formatting. Then commit.

### 8. Common findings checklist

- [ ] Same package listed twice in one `packages.nix`
- [ ] Same package in both system and home-manager packages
- [ ] Detailed config with `enable = false` (dead config)
- [ ] Commented-out imports that mask dead files
- [ ] Unused flake inputs (declared but never imported)
- [ ] Wrong wallpaper/image paths
- [ ] All 14 `LC_*` vars set individually
- [ ] Services enabled that are already defaults (`dbus`, `udev`)
- [ ] `nix.settings.download-buffer-size` inconsistency across hosts
- [ ] SSH user references that don't match the host's users
- [ ] Old hostnames or paths from a previous machine name
- [ ] `extraCompatPackages` with non-compat packages (e.g. cursor themes)
