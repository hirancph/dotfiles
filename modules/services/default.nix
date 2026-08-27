{...}: {
  imports = [
    ./flatpak.nix
    ./gnome-services.nix
    ./network
    ./pipewire.nix
    ./polkit.nix
    ./power-profiles.nix
    ./xserver.nix
  ];
}
