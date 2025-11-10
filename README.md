# nix-config

Personal NixOS configuration repository

---

## Overview

This repository contains my personal configurations for [NixOS](https://nixos.org/), including system settings, user environment customizations, and package installations. It is designed to provide a reproducible, portable, and declarative setup tailored to my needs.

## Features

- Declarative NixOS system configuration
- Custom user environment with preferred packages and tools
- Dotfiles and shell setup integrated with Nix
- Modular and easy to extend structure
- Automated setup for essential software and services

## Getting Started

### Prerequisites

- A working NixOS installation
- Basic familiarity with Nix and NixOS configuration files
- Access to clone this repository

### Installation

1. Clone the repository:

```bash
git clone https://github.com/OffRakki/nix-config.git
```

2. Edit the files as you wish and then rebuild:

```bash
sudo nixos-rebuild switch --flake <path-to-folder>
```

3. For user-level environment, source relevant shell files or restart your shell.

## Customization

You can adapt this configuration by:

- Editing `configuration.nix` for system-wide options
- Adding/removing packages in `packages.nix`
- Adjusting user environment in `home.nix` (if applicable)
- Configuring system services in `services.nix`

## Resources

- [NixOS Official Documentation](https://nixos.org/manual/nixos/stable/)
- [Home Manager Documentation](https://nix-community.github.io/home-manager/)
- [Nix Pills - Learn Nix language](https://nixos.org/guides/nix-pills/)
- [NixOS Wiki](https://nixos.wiki/)

## Contributing

Feel free to open issues or make pull requests to suggest improvements.

## License

GPL-3.0 license
---

**Note:** This configuration is tailored specifically for my personal hardware and usage preferences. Use at your own risk.
