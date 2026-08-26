{...}: {
  imports = [
    ./flatpak.nix
    ./network
    ./pipewire.nix
    ./polkit.nix
    ./power-profiles.nix
    ./xserver.nix
  ];
}
