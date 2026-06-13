---
name: nix
description: Use when working with NixOS rebuilds, Nix package management, and flake workflows. Covers nh os build/switch, nix shell/run for one-off programs, and syncing jj commits with the flake for evaluation.
---

# Nix

## Rebuild

Split rebuilds into **two steps** — always, every time:

1. **Build here** (no sudo needed, output visible in chat):
   `nixos-rebuild build --flake <path>`

2. **Apply on terminal** (spawns a kitty window for interactive auth):
   `kitty --directory <workdir> -e sh -c 'nh os <option> <flake-path> || exec bash' &`

   Where `<option>` is `switch` or `build` and `<flake-path>` is the full path to the
   flake (e.g. `/home/rakki/Documents/NixConfig`). `nh` doesn't auto-detect the
   flake from the working directory — it needs it as an explicit argument or via
   the `NH_OS_FLAKE` env var.

## Package Management

Machines not running NixOS may have **Nix standalone** installed instead. For
one-off programs that aren't already available, use `nix shell` or `nix run`
rather than `apt install`. Prefer `nix run nixpkgs#tool -- args` for fire-and-
forget usage, or `nix shell nixpkgs#tool -c ...` when chaining.

IMPORTANT: if you run into e.g. `python3: command not found`, ALWAYS try again with nix shell/run.

## Flake and Version Control

Flake evaluation uses git under the hood via `builtins.fetchGit`. To make jj
commits visible to the flake, use `jj bookmark move master --to '@' && jj git
export` to sync jj's state into the git refs.
