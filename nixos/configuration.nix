{
  imports = [
    ./hardware-configuration.nix
    ./../modules
  ];

  networking.hostName = "nixos";

  # Don't change
  system.stateVersion = "26.05";
}
