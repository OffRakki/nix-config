{
  imports = [
  # ./amd-drivers.nix
  # ./intel-drivers.nix
    ./nvidia-drivers.nix
    ./nvidia-prime-drivers.nix
    ./vm-guest-services.nix
    ./local-hardware-clock.nix
  ];
}
