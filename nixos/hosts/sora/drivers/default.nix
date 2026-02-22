{
  imports = [
  # ./amd-drivers.nix
  # ./intel-drivers.nix
    # ./vm-guest-services.nix
    ./nvidia-drivers.nix
    ./nvidia-prime-drivers.nix
    ./local-hardware-clock.nix
  ];
}
